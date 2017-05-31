attribute vec3 vPosition;
attribute vec3 vNormal;
attribute vec2 vTexCoord;

attribute vec4 boneIDs;
attribute vec4 boneWeights;
uniform mat4 boneTransforms[64];

varying vec2 texCoord;
varying vec3 pos;
varying vec3 Lvec1, Lvec2, Lvec3, Lveci3;
varying vec3 N;


uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition1, LightPosition2, LightPosition3;



void main()
{
    mat4 boneTransform = boneWeights[0] * boneTransforms[int(boneIDs[0])] +
                     boneWeights[1] * boneTransforms[int(boneIDs[1])] +
                     boneWeights[2] * boneTransforms[int(boneIDs[2])] +
                     boneWeights[3] * boneTransforms[int(boneIDs[3])];
                     
    vec4 vpos = boneTransform*vec4(vPosition, 1.0);

    // Transform vertex position into eye coordinates
    pos = (ModelView * vpos).xyz;

    // The vector to the light from the vertex    
    Lvec1 = LightPosition1.xyz - pos;
    Lvec2 = LightPosition2.xyz - pos;
    Lvec3 = LightPosition3.xyz - pos;
    Lveci3 = LightPosition3.xyz - vpos.xyz;
    
    // Transform vertex normal into eye coordinates (assumes scaling
    // is uniform across dimensions)
    N = normalize( (ModelView*boneTransform*vec4(vNormal, 0.0)).xyz );
    


    gl_Position = Projection * ModelView * vpos;
    texCoord = vTexCoord;
}
