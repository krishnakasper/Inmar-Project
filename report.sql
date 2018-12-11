-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2018 at 07:20 AM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.0.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--Problem Statement - 2

--SQL to get the number of retailers available in the system.
SELECT Count(*) FROM `retailers` 

--SQL to get the shoppers counts for each retailer (who purchased).
SELECT `creditor` as Retailer, COUNT(`debitor`) as Count FROM `transactions` GROUP BY creditor

--SQL to get all the shoppers count.
SELECT COUNT(`debitor`) as Total_Shopper_Count FROM `transactions` 

--SQL to get purchase amount per day wrt to a retailer.
SELECT SUM(`amount`), DATE(`date`), `creditor` FROM `transactions` GROUP BY creditor, DATE(date)

--SQL to find top retailer based on the number of purchases - Bonus points
SELECT tempTable.debitor, MAX(tempTable.count) from (SELECT `debitor`,COUNT(debitor)as count FROM `transactions` GROUP BY debitor) tempTable

--SQL to find a loyal shopper of any retailer based on the number of purchased more than threshold 5 - Bonus points
SELECT creditor,`debitor`,COUNT(debitor)as count FROM `transactions` GROUP BY creditor,debitor HAVING COUNT(debitor)>5 
