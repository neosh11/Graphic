varying vec4 color;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded

uniform float texScale;
uniform sampler2D texture;


varying vec4 export;
varying vec3 pos;
varying vec3 Lvec;
varying vec3 N;


uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;
uniform float Shininess;

void main()
{

    // Unit direction vectors for Blinn-Phong shading calculation
    vec3 L = normalize( Lvec );   // Direction to the light source
    vec3 E = normalize( -pos );   // Direction to the eye/camera
    vec3 H = normalize( L + E );  // Halfway vector


    // Compute terms in the illumination equation
    vec3 ambient = AmbientProduct;

    float Kd = max( dot(L, N), 0.0 );
    vec3  diffuse = Kd*DiffuseProduct;

    float Ks = pow( max(dot(N, H), 0.0), Shininess );
    vec3  specular = Ks * SpecularProduct;
    
    if (dot(L, N) < 0.0 ) {
	specular = vec3(0.0, 0.0, 0.0);
    } 

    // globalAmbient is independent of distance from the light source
    vec3 globalAmbient = vec3(0.05, 0.05, 0.05);
    
    
    gl_FragColor = vec4(globalAmbient +(ambient + diffuse + specular)/(length(Lvec)*length(Lvec)),1.0)* texture2D( texture, texCoord * texScale );
}
