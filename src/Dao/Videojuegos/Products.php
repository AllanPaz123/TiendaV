<?php

namespace Dao\Videojuegos;

use Dao\Table;

class products extends Table
{
    public static function getProducts(
        string $partialName = "",
        string $productStatus = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $pageNumber = 0,
        int $itemsPerPage = 10
    ) {
        $sql = "SELECT SQL_CALC_FOUND_ROWS * FROM products WHERE 1=1 ";
        $params = [];

        if ($partialName !== "") {
            $sql .= " AND productName LIKE :partialName ";
            $params["partialName"] = "%$partialName%";
        }

        if ($productStatus !== "") {
            $sql .= " AND productStatus = :productStatus ";
            $params["productStatus"] = $productStatus;
        }

        $allowedOrderFields = ["productId", "productName", "productPrice"];
        if ($orderBy !== "" && in_array($orderBy, $allowedOrderFields)) {
            $orderDir = $orderDescending ? "DESC" : "ASC";
            $sql .= " ORDER BY $orderBy $orderDir ";
        }

        $sql .= " LIMIT :offset, :limit ";
        $params["offset"] = $pageNumber * $itemsPerPage;
        $params["limit"] = $itemsPerPage;


        $products = self::obtenerRegistros($sql, $params);

        $totalRes = self::obtenerUnRegistro("SELECT FOUND_ROWS() AS total;", []);
        $total = $totalRes ? intval($totalRes["total"]) : 0;

        return ["products" => $products, "total" => $total];
    }

    public static function getProductById(int $productId)
    {
        $sqlstr = "SELECT * FROM products WHERE productId = :productId;";
        return self::obtenerUnRegistro($sqlstr, ["productId" => $productId]);
    }

    public static function nuevoProducto(
        string $productName,
        string $productDescription,
        float $productPrice,
        string $productImgUrl,
        int $productStock,
        string $productStatus
    ) {
        $sqlstr = "INSERT INTO products 
                    (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
                   VALUES 
                    (:productName, :productDescription, :productPrice, :productImgUrl, :productStock, :productStatus);";
        return self::executeNonQuery(
            $sqlstr,
            [
                "productName" => $productName,
                "productDescription" => $productDescription,
                "productPrice" => $productPrice,
                "productImgUrl" => $productImgUrl,
                "productStock" => $productStock,
                "productStatus" => $productStatus
            ]
        );
    }

    public static function actualizarProducto(
        int $productId,
        string $productName,
        string $productDescription,
        float $productPrice,
        string $productImgUrl,
        int $productStock,
        string $productStatus
    ): int {
        $sqlstr = "UPDATE products 
                   SET productName = :productName,
                       productDescription = :productDescription,
                       productPrice = :productPrice,
                       productImgUrl = :productImgUrl,
                       productStock = :productStock,
                       productStatus = :productStatus
                   WHERE productId = :productId;";
        return self::executeNonQuery(
            $sqlstr,
            [
                "productName" => $productName,
                "productDescription" => $productDescription,
                "productPrice" => $productPrice,
                "productImgUrl" => $productImgUrl,
                "productStock" => $productStock,
                "productStatus" => $productStatus,
                "productId" => $productId
            ]
        );
    }

    public static function eliminarProducto(int $productId): int
    {
        $sqlstr = "DELETE FROM products WHERE productId = :productId;";
        return self::executeNonQuery(
            $sqlstr,
            [
                "productId" => $productId
            ]
        );
    }

    // Actualizar stock (por ejemplo para restar stock al hacer una venta)
    public static function updateStock(int $productId, int $quantity): int
    {
        $sql = "UPDATE products SET productStock = productStock - :quantity
            WHERE productId = :productId AND productStock >= :quantity";
        $params = [
            "quantity" => $quantity,
            "productId" => $productId
        ];
        return self::executeNonQuery($sql, $params);
    }
}
