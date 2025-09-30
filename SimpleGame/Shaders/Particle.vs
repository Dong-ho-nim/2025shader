#version 330

in vec3 a_Position;
in float a_Value;
in vec4 a_Color;
in float a_STime;
in vec3 a_Vel;
in float a_LifeTime;
in float a_Mass;
in float a_Period;

out vec4 v_Color;

uniform float u_Time;

const float c_Pi = 3.141592;
const vec2 c_G = vec2(0, -9.8);

void fountain()
{
    float lifeTime = a_LifeTime;
    float newAlpha = 1.0;
    float newTime = u_Time - a_STime;
    vec4 newPosition = vec4(a_Position, 1.0);

    if (newTime > 0.0)
    {
        // vec2 u_Force = vec2(0.0); // 필요 시 선언

        // float fX = c_G.x * a_Mass + u_Force.x * 10.0;
        // float fY = c_G.y * a_Mass + u_Force.y * 10.0;
        // float aX = fX / a_Mass;
        // float aY = fY / a_Mass;

        // float t = fract(newTime / lifeTime) * lifeTime;
        // float tt = t * t;
        // float x = a_Vel.x * t + 0.5 * aX * tt;
        // float y = a_Vel.y * t + 0.5 * aY * tt;

        // newPosition.xy += vec2(x, y);
        // newAlpha = 1.0 - t / lifeTime;
    }
    else
    {
        newPosition.xy -= vec2(100000.0, 0.0);
    }

    gl_Position = newPosition;
    v_Color = vec4(a_Color.rgb, newAlpha);
}

void sinParticle()
{
    vec4 centerC = vec4(1, 0, 0, 1);
    vec4 borderC = vec4(1, 1, 1, 1);
    vec4 newColor = a_Color;
    vec4 newPosition = vec4(a_Position, 1.0);
    float newAlpha = 1.0;
    float lifeTime = a_LifeTime;
    float amp = a_Value * 2.0 - 1.0;
    float period = a_Period*2;

    float newTime = u_Time - a_STime;

    if (newTime > 0.0)
    {
        float t = fract(newTime / lifeTime) * lifeTime;
        float tt = t * t;
        float nTime = t / lifeTime;
        float x = nTime * 2.0 - 1.0;
        float y = nTime*sin(nTime*c_Pi) * amp * sin(period * (2.0 * c_Pi * nTime));

        newPosition.xy += vec2(x, y);
        newAlpha = 1.0 - t / lifeTime;

        float d = abs(y);
        newColor = mix(centerC, borderC, d*20);
    }
    else
    {
        newPosition.xy = vec2(-10000.0, 0.0);
    }

    gl_Position = newPosition;
    v_Color = vec4(newColor.rgb, newAlpha);
}

void circleParticle()
{
    float newAlpha = 1.0;
    float lifeTime = a_LifeTime;
    vec4 newPosition = vec4(a_Position, 1.0);

    float newTime = u_Time - a_STime;

    if( newTime > 0 )
    {
        float value = a_Value * 2 * c_Pi;
        float t = fract(newTime/lifeTime)*lifeTime;	
		float tt = t*t;

        float x = sin(value);
        float y = cos(value);

        float newX = x + 0.5 * c_G.x * tt;
        float newY = y + 0.5 * c_G.y * tt;

        newPosition.xy += vec2(newX, newY);
        newAlpha = 1.0 - t/lifeTime;
    }
    else
    {
        newPosition.xy = vec2(-10000.0, 0.0);
    }

    gl_Position = newPosition;
	v_Color = vec4(a_Color.rgb, newAlpha);
}

void main()
{
    // fountain();
    // sinParticle();
    circleParticle();
}
