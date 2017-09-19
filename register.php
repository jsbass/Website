<?php
require_once('Authentication.php');
$username = "";
$email = "";
$password = "";
$confirm = "";
$messages = array();
if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if(!empty($_POST["username"])) {
        $username = htmlspecialchars(addslashes(trim($_POST["username"])));
    } else {
        $message[] = "Username required";
    }
    if(!empty($_POST["email"])) {
        $email = htmlspecialchars(addslashes(trim($_POST["email"])));;
    } else {
        $messages[] = "Email required";
    }
    if(!empty($_POST["password"])) {
        $password = htmlspecialchars(addslashes(trim($_POST["password"])));;
    } else {
        $messages[] = "Password required";
    }
    if(!empty($_POST["confirm"])) {
        $confirm = htmlspecialchars(addslashes(trim($_POST["confirm"])));
    }
        
    if($username != "" && email != "" && password != "") {
        if(password == confirm) {
            $status = Authentication.Create($username, $email, $password, true);
            switch($status) {
                case CreateStatusCode::$Success:
                    header('Location: /login.php');
                    die();
                case CreateStatusCode::$UserExists:
                    $messages[] = "Username already exists";
                    break;
                case CreateStatusCode::$InsertFailed:
                    $messages[] = "Something went wrong. Please Try Again";
                    break;
            }
        } else {
            $messages[] = "Passwords must match";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>

<form id="login" method="POST">
    <ul style="color: red;">
        <?
            foreach($messages as $message) {
                echo "<li>".$message."</li>";
            }
        ?>
    </ul>
    <label for="username">Username</label><input name="username" type="text" value="<?$username?>" placeholder="Enter Username" />
    <label for="email">Email</label><input name="email" type="text" value="<?$email?>" placeholder="Enter Email" />
    <label for="password">Password</label><input name="password" type="password" placeholder="Confirm Password" />
    <label for="confirm">Confirm Password</label><input name="confirm" type="password" placeholder="Confirm Password" />
    <button type="submit">Submit</button>
</form>
</body>