<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Utilities\PayPal\PayPalRestApi;
use Utilities\Context;
use Dao\VideoJuegos\Transactions;
use Dao\VideoJuegos\TransactionDetails;
use Dao\VideoJuegos\Products;
use Dao\Cart\Cart;
use Views\Renderer;

class Accept extends PublicController
{
    public function run(): void
    {
        $dataview = [];
        $token = $_GET["token"] ?? "";
        $session_token = $_SESSION["orderid"] ?? "";
        $usercod = \Utilities\Security::getUserId();
        // $usercod = $_SESSION["usercod"] ?? null;
        /*if (!isset($_SESSION["usercod"])) {
            \Utilities\Site::redirectToWithMsg("index.php?page=Sec-Login", "Debes iniciar sesión para completar la compra.");
            return;
        }*/
        //$usercod = $_SESSION["usercod"];

        if ($token !== "" && $token == $session_token) {
            // Verifica si ya fue procesada
            if (Transactions::getTransactionByPaypalId($session_token)) {
                $dataview["msg"] = "Esta orden de PayPal ya fue procesada anteriormente.";
                Renderer::render("paypal/accept", $dataview);
                return;
            }

            // Captura de orden
            $PayPalRestApi = new PayPalRestApi(
                Context::getContextByKey("PAYPAL_CLIENT_ID"),
                Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);

            if (!isset($result->status) || $result->status !== "COMPLETED") {
                $dataview["msg"] = "Error al procesar la orden de PayPal.";
                Renderer::render("paypal/accept", $dataview);
                return;
            }

            // Datos correctos usando el objeto devuelto por PayPal
            $status = $result->status;
            $totalAmount = $result->purchase_units[0]->payments->captures[0]->amount->value;
            $currency = $result->purchase_units[0]->payments->captures[0]->amount->currency_code;
            $payerEmail = $result->payer->email_address;

            // Insertar transacción
            $insertData = [
                "usercod" => $usercod,
                "paypal_order_id" => $session_token,
                "txnAmount" => $totalAmount,
                "txnStatus" => $status,
                "txnDate" => date("Y-m-d H:i:s"),
                "txnCurrency" => $currency,
                "txnPayerEmail" => $payerEmail
            ];
            Transactions::insertTransaction($insertData);

            // Obtener ID de la transacción recién insertada
            $txn = Transactions::getTransactionByPaypalId($session_token);
            $txnId = $txn["txnId"];

            // Obtener carrito del usuario
            $carrito = Cart::getCartByUser($usercod);
            foreach ($carrito as $item) {
                $productId = $item["productId"];
                $quantity = $item["crrctd"];
                $price = $item["crrprc"];

                // Guardar detalle
                TransactionDetails::insertDetail($txnId, $productId, $quantity, $price);

                // Actualizar stock
                Products::updateStock($productId, $quantity);
            }

            // Vaciar carrito
            Cart::clearCart($usercod);

            // Mostrar mensaje de éxito
            $dataview["msg"] = "¡Compra procesada exitosamente!";
            $dataview["orderjson"] = json_encode($result, JSON_PRETTY_PRINT);
        } else {
            $dataview["msg"] = "Orden inválida o token no coincide.";
            $dataview["orderjson"] = "No Order Available!!!";
        }

        Renderer::render("paypal/accept", $dataview);
    }
}




/*
class Accept extends PublicController
{
    public function run(): void
    {
        $dataview = array();
        $token = $_GET["token"] ?: "";
        $session_token = $_SESSION["orderid"] ?: "";
        if ($token !== "" && $token == $session_token) {
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);
            $dataview["orderjson"] = json_encode($result, JSON_PRETTY_PRINT);
        } else {
            $dataview["orderjson"] = "No Order Available!!!";
        }
        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
*/