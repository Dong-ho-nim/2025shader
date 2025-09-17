#version 330

in vec3 a_Position;
in float a_Value;
in vec4 a_Color;

out vec4 v_Color;

uniform float u_Time;

const float c_PI = 3.141592;

void main()
{
	
	vec4 newPosition = vec4(a_Position, 1);
	gl_Position = newPosition;

	v_Color = a_Color;
}
