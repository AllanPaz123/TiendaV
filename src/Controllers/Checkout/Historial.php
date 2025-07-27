<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Videojuegos\Transactions;

class Historial extends PublicController
{
    public function run(): void
    {
        $usercod = $_SESSION["login"]["userId"];
        $transacciones = Transactions::getTransactionsByUser($usercod);

        \Views\Renderer::render("paypal/historial", [
            "transacciones" => $transacciones
        ]);
    }
}
