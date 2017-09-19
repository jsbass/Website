function Element() {
	this.tag = "";
	this.parent = null;
	this.children = [];
	this.contents = "";
	
	function getChildren(tag){
		var childs = [];
		for(child in this.children){
			if(child.tag == tag){
				childs.push(child);
			}
		}
		
		return childs;
	}
	
	function addChild(child){
		this.children.push(child);
	}
}

function parseXML(xml){
	var tokens = parseTokens(xml);
	this.i = 1;
	
	root = new Element();
	root.tag = "Root";
	
	buildtree(root);
	
	return root.children;
	
	function buildtree(node){
		
		if(tokens[i].type ==0){
			var child = new Element();
			child.tag = tokens[i].name;
			if(tokens[i+1].type == 2){
				child.contents = tokens[i+1].name
			}
			else {
				child.value = -999;
				child.parent = node;
				node.child = child;
			}
			i++;
			buildtree(child);
		}
		else if(tokens[i].type == 1){
			i++;
			buildtree(node);
		} else if(tokens[i].type == 2){
			i++;
			buildtree(node.parent);
		}
	}

	function parseTokens(xmlArray){
		xml.replace("(\\\\n|\\\\t|\\\\r)","");
		var xmlArr = xml.split("");
		var tokens = [];
		
		var dyntoken = "";
		var j=0;
		
		while(xmlArr[j] != "\0"){
			dyntoken = new token("",-1);
			while(xmlArr == " ") {j++;}
			if(xmlArr[j] == "<" && xmlArr[j+1] == "/"){
				while(xmlArr[j] != ">"){
					if(xmlArr[j] == "<"){
						continue;
					}
					j++;
					dyntoken.name = dyntoken.name + xmlArr[j];
				}
				j++;
				dyntoken.type = 0;
				tokens.push(dyntoken);
			}
			else if(xmlArr[j] != "<") {
				while(xmlArr[j] != "<" && xmlArr != "\0" && xmlArr[j] != "\r"){
					dyntoken.name = dyntoken.name + xmlArr[j];
					j++;
				}
				dyntoken.type = 2;
				tokens.push(dyntoken);
			}
			else if(xmlArr[j] == "<" && xmlArr[j+1] == "/"){
				while(xmlArr[j] != ">"){
					if(xmlArr[j] == "<" || xmlArr[j] == "/"){
						j++;
					}
					dyntoken.name = dyntoken.name + xmlArr[j];
					j++;
				}
				dyntoken.type = 1;
				tokens.push(dyntoken);
			}
			else {
				throw "Parsing failed illogically";
			}
		}
		
		return tokens;
	}
}

function token(name, type){
	this.name = name;
	this.type = type;
}