<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Cart\CartFns;

class Checkout extends PublicController
{
    public function run(): void
    {
        $viewData = [];
        $isLogged = Security::isLogged();
        $userId = $isLogged ? Security::getUserId() : null;
        $anonCod = !$isLogged ? CartFns::getAnnonCartCode() : null;

        // Obtener carrito
        $carretilla = $isLogged
            ? Cart::getAuthCart($userId)
            : Cart::getAnonCart($anonCod);

        if ($this->isPostBack()) {
            $processPayment = true;

            // Cambiar cantidades
            if (isset($_POST["removeOne"]) || isset($_POST["addOne"])) {
                $productId = intval($_POST["productId"]);
                $productoDisp = Cart::getProductoDisponible($productId);
                $amount = isset($_POST["removeOne"]) ? -1 : 1;

                // Obtener la cantidad actual del producto en el carrito
                $currentQty = 0;
                foreach ($carretilla as $item) {
                    if ($item['productId'] == $productId) {
                        $currentQty = $item['crrctd'];
                        break;
                    }
                }

                // Validar que no se pueda reducir a menos de 0
                if ($amount == -1 && $currentQty <= 0) {
                    $processPayment = false;
                } else {
                    if ($amount == 1) {
                        if ($productoDisp["productStock"] - $amount >= 0) {
                            $isLogged
                                ? Cart::addToAuthCart($productId, $userId, $amount, $productoDisp["productPrice"])
                                : Cart::addToAnonCart($productId, $anonCod, $amount, $productoDisp["productPrice"]);
                        }
                    } else {
                        // Solo permitir reducir si la cantidad actual es mayor a 0
                        if ($currentQty > 0) {
                            $isLogged
                                ? Cart::addToAuthCart($productId, $userId, $amount, $productoDisp["productPrice"])
                                : Cart::addToAnonCart($productId, $anonCod, $amount, $productoDisp["productPrice"]);
                        }
                    }

                    $carretilla = $isLogged
                        ? Cart::getAuthCart($userId)
                        : Cart::getAnonCart($anonCod);
                }

                $processPayment = false;
            }

            // Cancelar carretilla
            if (isset($_POST["cancelCart"])) {
                foreach ($carretilla as $producto) {
                    $cantidad = -$producto["crrctd"];
                    $isLogged
                        ? Cart::addToAuthCart($producto["productId"], $userId, $cantidad, $producto["crrprc"])
                        : Cart::addToAnonCart($producto["productId"], $anonCod,  $cantidad, $producto["crrprc"]);
                }

                $isLogged
                    ? Cart::removeCart($userId)
                    : Cart::removeAnonCart($anonCod);

                \Utilities\Site::redirectTo("index.php?page=index");
                return;
            }

            // Pago con PayPal
            if ($processPayment) {
                if (!$isLogged) {
                    \Utilities\Site::redirectToWithMsg(
                        "index.php?page=sec_login",
                        "Necesitas registrarte para continuar con la compra."
                    );
                    return;
                }
                $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                    "test" . (time() - 10000000),
                    "http://localhost:8080/negociosweb/index.php?page=Checkout_Error",
                    "http://localhost:8080/negociosweb/index.php?page=Checkout_Accept"
                );

                foreach ($carretilla as $producto) {
                    $PayPalOrder->addItem(
                        $producto["productName"],
                        $producto["productDescription"],
                        $producto["productId"],
                        $producto["crrprc"],
                        0,
                        $producto["crrctd"],
                        "DIGITAL_GOODS"
                    );
                }

                $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                    \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                    \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
                );
                $PayPalRestApi->getAccessToken();
                $response = $PayPalRestApi->createOrder($PayPalOrder);

                if (isset($response->id)) {
                    $_SESSION["orderid"] = $response->id;
                    foreach ($response->links as $link) {
                        if ($link->rel == "approve") {
                            \Utilities\Site::redirectTo($link->href);
                        }
                    }
                    die();
                } else {
                    \Utilities\Site::redirectTo("index.php?page=Checkout_Error");
                }
            }
        }

        // Renderizar vista
        $finalCarretilla = [];
        $counter = 1;
        $total = 0;
        foreach ($carretilla as $prod) {
            $prod["row"] = $counter;
            $prod["subtotal"] = number_format($prod["crrprc"] * $prod["crrctd"], 2);
            $total += $prod["crrprc"] * $prod["crrctd"];
            $prod["crrprc"] = number_format($prod["crrprc"], 2);
            $finalCarretilla[] = $prod;
            $counter++;
        }

        $viewData["carretilla"] = $finalCarretilla;
        $viewData["total"] = number_format($total, 2);
        \Views\Renderer::render("paypal/checkout", $viewData);
    }
}
