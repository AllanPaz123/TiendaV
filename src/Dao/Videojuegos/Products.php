<?php

namespace Dao\VideoJuegos;

use Dao\Table;

class products extends Table
{
    public static function getProducts()
    {
        $sqlstr = "SELECT * FROM products;";
        return self::obtenerRegistros($sqlstr, []);
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

    //actualizar stock
    public static function updateStock($productId, $quantity)
    {
        $sql = "UPDATE products SET productStock = productStock - :quantity
            WHERE productId = :productId AND productStock >= :quantity";
        $params = compact("quantity", "productId");
        return self::executeNonQuery($sql, $params);
    }
}
