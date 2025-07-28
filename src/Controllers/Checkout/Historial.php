<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\VideoJuegos\Transactions;
use Dao\VideoJuegos\TransactionDetails;
use Views\Renderer;

class Historial extends PublicController
{
    public function run(): void
    {
        $dataview = [];
        $usercod = \Utilities\Security::getUserId();
        //$usercod = $_SESSION["usercod"] ?? null;

        if (!$usercod) {
            \Utilities\Site::redirectToWithMsg("index.php", "Debes iniciar sesión para ver tu historial.");
        }

        $historial = Transactions::getUserTransactionHistory($usercod);

        foreach ($historial as &$transaccion) {
            $transaccion["productos"] = TransactionDetails::getDetailsByTxnId($transaccion["txnId"]);
        }

        $dataview["historial"] = $historial;
        Renderer::render("paypal/historial", $dataview);
    }
}
