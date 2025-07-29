<?php

namespace Controllers\Videojuegos;

use Controllers\PrivateController;
use Dao\Videojuegos\Products as ProductsDao;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

class Product extends PrivateController
{
    private array $viewData = [];
    private string $mode = "DSP";
    private array $modeDescriptions = [
        "DSP" => "Detalle de %s %s",
        "INS" => "Nuevo Producto",
        "UPD" => "Editar %s %s",
        "DEL" => "Eliminar %s %s"
    ];
    private string $readonly = "";
    private bool $showCommitBtn = true;
    private array $product = [
        "productId" => 0,
        "productName" => "",
        "productDescription" => "",
        "productPrice" => 0,
        "productImgUrl" => "",
        "productStock" => 0,
        "productStatus" => "ACT"
    ];
    private string $product_xss_token = "";

    public function run(): void
    {
        try {
            $this->getData();

            if ($this->isPostBack()) {
                if ($this->validateData()) {
                    $this->handlePostAction();
                }
            }

            $this->setViewData();
            Renderer::render("Videojuegos/Product", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Videojuegos-Products",
                $ex->getMessage()
            );
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";

        if (isset($this->modeDescriptions[$this->mode])) {
            if (!$this->isFeatureAutorized("product_" . $this->mode)) {
                throw new \Exception("No tiene permisos para realizar esta acción.", 1);
            }

            $this->readonly = in_array($this->mode, ["DEL", "DSP"]) ? "readonly" : "";
            $this->showCommitBtn = ($this->mode !== "DSP");


            if ($this->mode !== "INS") {
                $productId = intval($_GET["productId"] ?? 0);
                if ($productId <= 0) {
                    throw new \Exception("ID de producto inválido.", 1);
                }

                $this->product = ProductsDao::getProductById($productId);
                if (!$this->product) {
                    throw new \Exception("No se encontró el Producto", 1);
                }
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad invalida", 1);
        }
    }

    private function validateData(): bool
    {
        $errors = [];
        $this->product_xss_token = $_POST["product_xss_token"] ?? "";
        $this->product["productId"] = intval($_POST["productId"] ?? 0);

        // Solo validar en INS y UPD
        if (!in_array($this->mode, ["DEL"])) {
            $this->product["productName"] = trim(strval($_POST["productName"] ?? ""));
            $this->product["productDescription"] = trim(strval($_POST["productDescription"] ?? ""));
            $this->product["productPrice"] = floatval($_POST["productPrice"] ?? 0);
            $this->product["productImgUrl"] = trim(strval($_POST["productImgUrl"] ?? ""));
            $this->product["productStock"] = intval($_POST["productStock"] ?? 0);
            $this->product["productStatus"] = trim(strval($_POST["productStatus"] ?? ""));

            if (Validators::IsEmpty($this->product["productName"])) {
                $errors["productName_error"] = "El nombre del producto es requerido";
            }

            if (Validators::IsEmpty($this->product["productDescription"])) {
                $errors["productDescription_error"] = "La descripción del producto es requerida";
            }

            if ($this->product["productPrice"] <= 0) {
                $errors["productPrice_error"] = "El precio debe ser mayor a cero";
            }

            if (Validators::IsEmpty($this->product["productImgUrl"])) {
                $errors["productImgUrl_error"] = "La imagen del producto es requerida";
            }

            if (!in_array($this->product["productStatus"], ["ACT", "INA", "DSC"])) {
                $errors["productStatus_error"] = "El estado del producto es inválido";
            }
        }

        $tmpXsrToken = $_SESSION["product_xss_token"] ?? '';
        if ($this->product_xss_token !== $tmpXsrToken) {
            throw new \Exception("Solicitud inválida. Intente de nuevo.");
        }

        if (count($errors) > 0) {
            foreach ($errors as $key => $val) {
                $this->product[$key] = $val;
            }
            return false;
        }

        return true;
    }

    private function handlePostAction(): void
    {
        switch ($this->mode) {
            case "INS":
                $this->handleInsert();
                break;
            case "UPD":
                $this->handleUpdate();
                break;
            case "DEL":
                $this->handleDelete();
                break;
            default:
                throw new \Exception("Modo inválido", 1);
        }
    }

    private function handleInsert(): void
    {
        $result = ProductsDao::nuevoProducto(
            $this->product["productName"],
            $this->product["productDescription"],
            $this->product["productPrice"],
            $this->product["productImgUrl"],
            $this->product["productStock"],
            $this->product["productStatus"]
        );

        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Videojuegos-Products",
                "Producto creado exitosamente"
            );
        } else {
            throw new \Exception("No se pudo insertar el producto");
        }
    }

    private function handleUpdate(): void
    {
        $result = ProductsDao::actualizarProducto(
            $this->product["productId"],
            $this->product["productName"],
            $this->product["productDescription"],
            $this->product["productPrice"],
            $this->product["productImgUrl"],
            $this->product["productStock"],
            $this->product["productStatus"]
        );

        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Videojuegos-Products",
                "Producto actualizado exitosamente"
            );
        } else {
            throw new \Exception("No se pudo actualizar el producto");
        }
    }

    private function handleDelete(): void
    {
        $result = ProductsDao::eliminarProducto($this->product["productId"]);

        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Videojuegos-Products",
                "Producto eliminado exitosamente"
            );
        } else {
            throw new \Exception("No se pudo eliminar el producto");
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["product_xss_token"] = hash("sha256", random_int(0, 1000000) . time() . 'product' . $this->mode);
        $_SESSION["product_xss_token"] = $this->viewData["product_xss_token"];

        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->product["productId"],
            $this->product["productName"]
        );

        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;

        $productStatusKey = "productStatus_" . strtolower($this->product["productStatus"]);
        $this->product[$productStatusKey] = "selected";

        $this->viewData["product"] = $this->product;
    }
}
