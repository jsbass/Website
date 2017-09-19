<?php
class SqlHelper {    
    private $conn;
    
    
    function __construct($servername, $username, $password, $database) {
        $this->conn = new mysqli($servername, $username, $password. $database);
        if($this->conn->connect_error) {
            throw new Exception($this->conn->connect_error);
        }
    }
    
    function __destruct() {
        $this->conn->close();
    }
    
    function getRecords($query, $types, ...$params) {
        if(!$stmt = $this->conn->prepare($query)) {
            throw new Exception($this->conn->error);
        }
        if(!$stmt->bind_param($types, $params)) {
            throw new Exception($stmt->error);
        }
        if(!$stmt->execute()) {
            $stmt->free_result();
            throw new Exception($stmt->error);
        }
        if($result = !$stmt->get_result()) {
            $stmt->free_result();
            throw new Exception($stmt->error);
        }
        $arr = $result->fetch_all();
        $result->free();
        return $arr;
    }
    
    
}
function sanitize($input) {
    $input = trim($input);
    $input = stripslashes($input);
    $input = htmlspecialchars($input);
    return $input;
}
?>