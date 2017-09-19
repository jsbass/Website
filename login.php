<?php
require_once('Authentication.php');
$username = "";
$password = "";
session_start();
if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if(!empty($_POST["username"])) {
        $username = htmlspecialchars(addslashes(trim($_POST["username"])));
    }
    if(!empty($_POST["password"])) {
        $password = $_POST["password"];
    }
    if($username != "" && password != "") {
        if(Authentication.LogIn($username, $password)) {
            header('Location: index.php');
            die();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
</head>
<body>

<form id="login" method="POST">
<label for="username">Username</label><input type="text" value="<?php $username?>" placeholder="Enter Username" />
<label for"password">Password</label><input type="password" placeholder="Enter Password" />
<button type="submit">Submit</button>
</form>
</body>