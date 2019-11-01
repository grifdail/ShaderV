tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVclampAlpha

func _get_name():
	return "ClampAlphaBorder"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Clamp alpha to border vec4(0, 0, 1, 1)"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return 2

func _get_input_port_name(port):
	match port:
		0:
			return "alpha"
		1:
			return "uv"

func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	match port:
		0:
			return "alpha"

func _get_output_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	return """
float clampAlphaBorderFunc(float _color_alpha_clamp, vec2 _uv_clamp){
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(_uv_clamp.x), 0.0));
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(1.0 - _uv_clamp.x), 0.0));
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(_uv_clamp.y), 0.0));
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(1.0 - _uv_clamp.y), 0.0));
	return _color_alpha_clamp;
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = clampAlphaBorderFunc(%s, (%s).xy);" % [input_vars[0], input_vars[1]]
