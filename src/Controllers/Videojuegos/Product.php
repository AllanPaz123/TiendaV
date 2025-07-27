<?php

namespace Controllers\Videojuegos;

use Controllers\PublicController;
use Dao\Videojuegos\Products as ProductsDAO;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

const LIST_URL = "index.php?page=Videojuegos-Products";
const XSR_KEY = "xsrToken_products";

class Product extends PublicController
{
    private array $viewData;
    private array $modes;

    public function __construct()
    {
        $this->modes = [
            "INS" => 'Agregando un nuevo producto',
            "UPD" => 'Editando producto %s (%s)',
            "DEL" => 'Eliminando producto %s (%s)',
            "DSP" => 'Detalle del producto %s (%s)'
        ];

        $this->viewData = [
            "productId" => 0,
            "productName" => "",
            "productDescription" => "",
            "productPrice" => "0.00",
            "productImgUrl" => "",
            "productStock" => 0,
            "productStatus" => "ACT",
            "mode" => "",
            "modeDsc" => "",
            "errores" => [],
            "readonly" => "",
            "showAction" => true,
            "xsrToken" => ""
        ];
    }

    public function run(): void
    {
        $this->capturarModoPantalla();
        $this->datosDeDao();
        if ($this->isPostBack()) {
            $this->datosFormulario();
            $this->validarDatos();
            if (count($this->viewData["errores"]) === 0) {
                $this->procesarDatos();
            }
        }
        $this->prepararVista();
        Renderer::render("Videojuegos/Product", $this->viewData);
    }

    private function throwError(string $message)
    {
        Site::redirectToWithMsg(LIST_URL, $message);
    }

    private function capturarModoPantalla()
    {
        if (isset($_GET["mode"])) {
            $this->viewData["mode"] = $_GET["mode"];
            if (!isset($this->modes[$this->viewData["mode"]])) {
                $this->throwError("BAD REQUEST: Modo no válido.");
            }
        }
    }

    private function datosDeDao()
    {
        if ($this->viewData["mode"] !== "INS") {
            if (isset($_GET["productId"])) {
                $this->viewData["productId"] = intval($_GET["productId"]);
                $product = ProductsDAO::getProductById($this->viewData["productId"]);
                if ($product) {
                    $this->viewData = array_merge($this->viewData, $product);
                } else {
                    $this->throwError("No se encontró el producto solicitado.");
                }
            } else {
                $this->throwError("No se proporcionó el ID del producto.");
            }
        }
    }

    private function datosFormulario()
    {
        foreach (["productName", "productDescription", "productPrice", "productImgUrl", "productStock", "productStatus", "xsrToken"] as $campo) {
            if (isset($_POST[$campo])) {
                $this->viewData[$campo] = $_POST[$campo];
            }
        }
    }

    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["productName"])) {
            $this->viewData["errores"]["productName"] = "El nombre del producto es obligatorio.";
        }
        if (!is_numeric($this->viewData["productPrice"]) || floatval($this->viewData["productPrice"]) < 0) {
            $this->viewData["errores"]["productPrice"] = "El precio debe ser un número positivo.";
        }
        if (!in_array($this->viewData["productStatus"], ["ACT", "INA", "DSC"])) {
            $this->viewData["errores"]["productStatus"] = "Estado inválido.";
        }
        $tmpXsrToken = $_SESSION[XSR_KEY];
        if ($this->viewData["xsrToken"] !== $tmpXsrToken) {
            error_log("Token inválido en producto.");
            $this->throwError("Solicitud inválida. Intente de nuevo.");
        }
    }

    private function procesarDatos()
    {
        switch ($this->viewData["mode"]) {
            case "INS":
                if (ProductsDAO::nuevoProducto(
                    $this->viewData["productName"],
                    $this->viewData["productDescription"],
                    floatval($this->viewData["productPrice"]),
                    $this->viewData["productImgUrl"],
                    intval($this->viewData["productStock"]),
                    $this->viewData["productStatus"]
                ) > 0) {
                    Site::redirectToWithMsg(LIST_URL, "Producto agregado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al agregar el producto."];
                }
                break;
            case "UPD":
                if (ProductsDAO::actualizarProducto(
                    $this->viewData["productId"],
                    $this->viewData["productName"],
                    $this->viewData["productDescription"],
                    floatval($this->viewData["productPrice"]),
                    $this->viewData["productImgUrl"],
                    intval($this->viewData["productStock"]),
                    $this->viewData["productStatus"]
                )) {
                    Site::redirectToWithMsg(LIST_URL, "Producto actualizado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al actualizar el producto."];
                }
                break;
            case "DEL":
                if (ProductsDAO::eliminarProducto($this->viewData["productId"])) {
                    Site::redirectToWithMsg(LIST_URL, "Producto eliminado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al eliminar el producto."];
                }
                break;
        }
    }

    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["productName"],
            $this->viewData["productId"]
        );

        if (count($this->viewData["errores"]) > 0) {
            foreach ($this->viewData["errores"] as $campo => $error) {
                $this->viewData["error_" . $campo] = $error;
            }
        }

        if (in_array($this->viewData["mode"], ["DEL", "DSP"])) {
            $this->viewData["readonly"] = "readonly";
        }
        if ($this->viewData["mode"] === "DSP") {
            $this->viewData["showAction"] = false;
        }

        $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'product' . $this->viewData["mode"]);
        $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
    }
}
