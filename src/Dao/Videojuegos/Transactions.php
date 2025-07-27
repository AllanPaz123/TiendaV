<?php

namespace Dao\Videojuegos;

use Dao\Table;

class Transactions extends Table
{
    public static function addTransaction($usercod, $total, $currency, $status)
    {
        $fecha = date("Y-m-d H:i:s");
        $sqlstr = "INSERT INTO transacciones (usercod, fecha, total) VALUES (:usercod, :fecha, :total)";
        $params = [
            "usercod" => $usercod,
            "fecha" => $fecha,
            "total" => $total
        ];
        self::executeNonQuery($sqlstr, $params);
    }

    public static function getAllTransactions()
    {
        $sql = "SELECT transaccionid, usercod, fecha, total FROM transacciones ORDER BY fecha DESC;";
        $transacciones = self::obtenerRegistros($sql, []);

        foreach ($transacciones as &$trx) {
            $trx["detalles"] = self::getTransactionDetails($trx["transaccionid"]);
        }

        return $transacciones;
    }
    public static function addTransactionDetail($transid, $productId, $cantidad, $precio)
    {
        $sql = "INSERT INTO transacciones_detalles (transaccionid, productId, cantidad, precio)
                VALUES (:transid, :productId, :cantidad, :precio)";
        return self::executeNonQuery($sql, compact("transid", "productId", "cantidad", "precio"));
    }

    public static function updateProductStock($productId, $cantidadComprada)
    {
        $sql = "UPDATE products SET productStock = productStock - :cantidad WHERE productId = :productId";
        return self::executeNonQuery($sql, ["cantidad" => $cantidadComprada, "productId" => $productId]);
    }

    public static function getTransactionsByUser($usercod)
    {
        $sql = "SELECT transaccionid, trxfecha, trxmonto, trxstatus FROM transacciones WHERE usercod = :usercod ORDER BY trxfecha DESC;";
        $transacciones = self::obtenerRegistros($sql, ["usercod" => $usercod]);

        foreach ($transacciones as &$trx) {
            $trx["detalles"] = self::getTransactionDetails($trx["transaccionid"]);
        }

        return $transacciones;
    }

    public static function getTransactionDetails($transaccionid)
    {
        $sql = "SELECT d.*, p.productName
                FROM transacciones_detalles d
                JOIN products p ON d.productId = p.productId
                WHERE d.transaccionid = :transaccionid";
        return self::obtenerRegistros($sql, ["transaccionid" => $transaccionid]);
    }
}
