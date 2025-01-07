class_name EnemyConditionLogic extends EnemyLogic

## Simple gdscript condition to run child logic
## The script is run as if it's a part of this node so
## it has access to for example: [code]enemy: Enemy[/code]
@export_multiline var condition: String

## A list of custom variables defined in the expression
@export var variables: Array[String] = []

## The values of the custom variables defined above in 'variables'
@export var values: Array[Node] = []

var _expression := Expression.new()

func evaluate() -> bool:
	return evaluate_expression()

func evaluate_expression() -> bool:
	var error = _expression.parse(condition, variables + ["Game"])
	
	if error != OK:
		push_error("Invalid expression in condition logic node: %s" % _expression.get_error_text())
		return false
		
	var result = _expression.execute(values + [Game], self)
	if _expression.has_execute_failed():
		push_error("Expression failed in condition logic node: %s" % _expression.get_error_text())
		return false
	
	if result is not bool:
		push_error("Expression did not return boolean in condition logic node")
		return false
	
	return result
