attribute vec3 vPosition;
attribute vec3 vNormal;
attribute vec2 vTexCoord;

varying vec2 texCoord;
varying vec3 pos;
varying vec3 Lvec;
varying vec3 N;

uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;

void main()
{
    vec4 vpos = vec4(vPosition, 1.0);

    // Transform vertex position into eye coordinates
    pos = (ModelView * vpos).xyz;

    // The vector to the light from the vertex    
    Lvec = LightPosition.xyz - pos;

    // Transform vertex normal into eye coordinates (assumes scaling
    // is uniform across dimensions)
    N = normalize( (ModelView*vec4(vNormal, 0.0)).xyz );

    gl_Position = Projection * ModelView * vpos;
    texCoord = vTexCoord;
}
