<?php

echo('two<br>');
/*
$apiPage = 'http://147.45.146.2/api.php';
$order = [
    "Customer" => [
	    "Name" => "Yakov Hrebtov",
        "Birthday" => "05.12.1977",
        "Sex" => "Male"
    ],
    "ShipDate" => "01.12.2024",
    "Goods" => [
        1 => [
            "Name" => "Тетрадь в клетку (48 листов)",
            "Price" => 70,
            "Quantity" => 10
        ],
        2 => [
            "Name" => "Ручка шариковая Parker (синяя)",
            "Price" => 90,
            "Quantity" => 2
        ]
    ]
]

$query = array(
	'method'  => 'OrderCost',
	'data' => json_encode($order, JSON_UNESCAPED_UNICODE)
);		
 
$ch = curl_init($apiPage);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($query, JSON_UNESCAPED_UNICODE)); 
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_HEADER, false);
$res = curl_exec($ch);
curl_close($ch);
 
//$res = json_encode($res, JSON_UNESCAPED_UNICODE);
print_r($res);
*/