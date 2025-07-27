<?php

namespace Controllers\Historial;

use Controllers\PublicController;
use Dao\Videojuegos\Transactions;
use Utilities\Security;
use Views\Renderer;

class Historial extends PublicController
{
    public function run(): void
    {
        $viewData = [];

        $isAdmin = Security::isUserInRole("ADMIN"); // o el código de rol que uses

        if ($isAdmin) {
            // Mostrar todas las transacciones
            $viewData["transacciones"] = Transactions::getAllTransactions();
            $viewData["titulo"] = "Historial General de Transacciones";
        } else {
            $userId = $_SESSION["login"]["userId"];
            $viewData["transacciones"] = Transactions::getTransactionsByUser($userId);
            $viewData["titulo"] = "Mis Transacciones";
        }


        Renderer::render("Historial/Historial", $viewData);
    }
}
