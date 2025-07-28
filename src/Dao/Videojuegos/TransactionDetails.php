<?php

namespace Dao\VideoJuegos;

use Dao\Table;

class transactionDetails extends Table
{
    public static function insertDetail($txnId, $productId, $quantity, $unitPrice)
    {
        $sql = "INSERT INTO transaction_details (txnId, productId, quantity, unitPrice)
            VALUES (:txnId, :productId, :quantity, :unitPrice)";
        $params = compact("txnId", "productId", "quantity", "unitPrice");
        return self::executeNonQuery($sql, $params);
    }

    public static function getDetailsByTxnId($txnId)
    {
        $sql = "SELECT d.quantity, d.unitPrice, p.productName
            FROM transaction_details d
            INNER JOIN products p ON d.productId = p.productId
            WHERE d.txnId = :txnId";
        return self::obtenerRegistros($sql, ["txnId" => $txnId]);
    }
}
