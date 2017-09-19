<?php
require_once("SqlInterface.php");

session_start();

class User {
    public $UserName = "";
    public $Email = "";
    public $Roles = array();
    
    public function IsInRole($name) {
        return in_array($this->Roles, $name);
    }
}

abstract class Authentication {
    private static $USER_SESSION_VAR = "ME_USER";
    private static $ALGO = "PASSWORD_BCRYPT";
    private static $sql = null;
    
    public static function IsAuthenticated() {
        return !empty($_SESSION[self::USER_SESSION_VAR]);
    }
    
    public static function GetUser() {
        if(self::IsAuthenticated()) {
            return clone $_SESSION[self::USER_SESSION_VAR];
        } else {
            return null;
        }
    }
    
    public static function IsInRole($name) {
        $user = self::GetUser();
        return $user->IsInRole($name);
    }
    
    public static function LogIn($username, $password) {
        $msgs = array();
        $records = self::$sql->getRecords("SELECT Hash,UserName,Email FROM User WHERE UserName = ?", 's', $username);
        if(empty($records)) {
            return false;
        }
        $hash = $user['Hash'];
        if(password_verify($password, $hash, self::ALGO)) {
            $user = new User();
            $user->UserName = $record["UserName"];
            $user->Email = $record["Email"];
            $user->Roles = explode($record["Roles"], ",");
            $_SESSION[self::$USER_SESSION_VAR] = $user;
            return true;
        } else {
            return false;
        }
    }
    
    public static function Create($username, $email, $password, $isVerified) {
        $records = self::$sql->getRecords("SELECT UserName FROM User WHERE UserName = ?", "s", $username);
        if(!empty($records)) {
            return CreateStatusCode::UserExists;
        }
        
        try{
            self::$sql->getRecords("INSERT INTO User (UserName, Email, Hash, IsVerified)", "sss", $username, $email, password_hash($password, self::$ALGO), $isVerified);
        } catch(Exception $ex) {
            return CreateStatusCode::$InsertFailed;
        }
        
        return CreateStatusCode::$Success;
    }
    public static function init() {
        if(!self::$sql) {
            self::$sql = new SqlHelper("localhost","jsbassou","Seabass_992", "jsbassou_auth");
        }
    }
    
    public static function RequireAuth(...$roles) {
        if(is_null($user = self::$GetUser())) {
            header('Location: /login.php?returnUrl=' . htmlspecialchars($_SERVER["REQUEST_URI"]));
            die();
        }
        
        foreach($roles as $role) {
            if($user->IsInRole($role)) {
                return true;
            }
        }
        
        return false;
    }
}

abstract class CreateStatusCode {
    public static $Success      = 0;
    public static $UserExists   = 1;
    public static $InsertFailed = 2;
}

Authentication::init();
?>