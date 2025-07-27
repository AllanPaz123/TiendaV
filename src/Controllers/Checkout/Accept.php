<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Utilities\Paypal\PayPalRestApi;
use Utilities\Context;
use Dao\Cart\Cart;
use Dao\Videojuegos\Transactions;
use Views\Renderer;

class Accept extends  PublicController
{
    public function run(): void
    {
        $dataview = [];
        $token = $_GET["token"] ?? "";
        $session_token = $_SESSION["orderid"] ?? "";

        if ($token !== "" && $token == $session_token) {
            $ppApi = new PayPalRestApi(
                Context::getContextByKey("PAYPAL_CLIENT_ID"),
                Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $ppApi->captureOrder($session_token);

            /* if (isset($result["status"]) && $result["status"] === "COMPLETED") {
                $usercod = $_SESSION["login"]["userId"];
                $total = $result["purchase_units"][0]["amount"]["value"];
                $currency = $result["purchase_units"][0]["amount"]["currency_code"];*/
            if (isset($result->status) && $result->status === "COMPLETED") {
                $usercod = $_SESSION["login"]["userId"];
                $total = $result->purchase_units[0]->amount->value;
                $currency = $result->purchase_units[0]->amount->currency_code;

                // Guardar transacción principal
                $transId = Transactions::addTransaction($usercod, $total, $currency, $result["status"]);

                // Obtener productos del carrito
                $productos = Cart::getCartItemsByUser($usercod);

                foreach ($productos as $item) {
                    Transactions::addTransactionDetail($transId, $item["productId"], $item["cantidad"], $item["precio"]);
                    Transactions::updateProductStock($item["productId"], $item["cantidad"]);
                }

                // Limpiar carrito
                Cart::clearCartByUser($usercod);

                $dataview["msg"] = "¡Transacción completada exitosamente!";
            } else {
                $dataview["msg"] = "Error al procesar la orden con PayPal.";
            }
        } else {
            $dataview["msg"] = "Orden inválida o expirada.";
        }

        Renderer::render("paypal/historial", $dataview);
    }
}
