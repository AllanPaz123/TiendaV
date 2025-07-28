<?php

namespace Dao\VideoJuegos;

use Dao\Table;

class transactions extends Table
{
    public static function insertTransaction($data)
    {
        $sql = "INSERT INTO transactions (usercod, paypal_order_id, txnAmount, txnStatus, txnDate, txnCurrency, txnPayerEmail)
            VALUES (:usercod, :paypal_order_id, :txnAmount, :txnStatus, :txnDate, :txnCurrency, :txnPayerEmail)";
        return self::executeNonQuery($sql, $data);
    }

    public static function getTransactionByPaypalId($paypal_order_id)
    {
        $sql = "SELECT * FROM transactions WHERE paypal_order_id = :paypal_order_id";
        $params = ["paypal_order_id" => $paypal_order_id];
        return self::obtenerUnRegistro($sql, $params);
    }

    public static function getUserTransactionHistory($usercod)
    {
        $sql = "SELECT t.txnId, t.paypal_order_id, t.txnDate, t.txnAmount, t.txnStatus, t.txnCurrency
            FROM transactions t
            WHERE t.usercod = :usercod
            ORDER BY t.txnDate DESC";
        return self::obtenerRegistros($sql, ["usercod" => $usercod]);
    }
}
