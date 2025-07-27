<?php

namespace Controllers\Videojuegos;

use Controllers\PublicController;
use Dao\Videojuegos\products as ProductosDAO;
use Views\Renderer;

class Products extends PublicController
{
    private array $viewData;

    public function __construct()
    {
        parent::__construct();
        $this->viewData = [
            "productos" => []
        ];
    }

    public function run(): void
    {
        $this->viewData["productos"] = ProductosDAO::getProducts();
        Renderer::render("Videojuegos/Products", $this->viewData);
    }
}
