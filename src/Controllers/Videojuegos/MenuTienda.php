<?php

namespace Controllers\Videojuegos;

use Controllers\PublicController;
use Views\Renderer;
use \Utilities\Site as Site;

class MenuTienda extends PublicController
{
    private array $viewData = [];

    public function run(): void
    {
        Site::addLink("public/css/HeaderComponent.css");

        $this->viewData["modeDsc"] = "Menú Principal - Gestión de la Tienda de Videojuegos";

        Renderer::render("Menu/MenuTienda", $this->viewData);
    }
}
