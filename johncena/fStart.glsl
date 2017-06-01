varying vec4 color;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded

uniform float texScale;
uniform sampler2D texture;


varying vec4 export;
varying vec3 pos;
varying vec3 Lvec1, Lvec2, Lvec3, Lveci3;
varying vec3 N;


uniform vec4 lightPoint;

uniform vec3 LightColor1, LightColor2, LightColor3;
uniform float LightBrightness1, LightBrightness2, LightBrightness3;

uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;
uniform float Shininess;


uniform vec4 LightPosition3;

void main()
{
    
    // Unit direction vectors for Blinn-Phong shading calculation
    vec3 L1 = normalize( Lvec1 );   // Direction to the light source
    vec3 L2 = normalize( Lvec2 );
    vec3 L3 = normalize( Lvec3 );
    vec3 E = normalize( -pos );   // Direction to the eye/camera
    vec3 H1 = normalize( L1 + E );  // Halfway vector
    vec3 H2 = normalize( L2 + E );
    vec3 H3 = normalize( L3 + E );

    // Compute terms in the illumination equation
    vec3 ambient1 = (LightColor1 * LightBrightness1) * AmbientProduct;
	vec3 ambient2 = (LightColor2 * LightBrightness2) * AmbientProduct;
	vec3 ambient3 = (LightColor3 * LightBrightness3) * AmbientProduct;
	
    float Kd1 = max( dot(L1, N), 0.0 );
    float Kd2 = max( dot(L2, N), 0.0 );
    float Kd3 = max( dot(L3, N), 0.0 );
    
    vec3 diffuse1 = Kd1 * (LightColor1 * LightBrightness1) * DiffuseProduct;
	vec3 diffuse2 = Kd2 * (LightColor2 * LightBrightness2) * DiffuseProduct;
	vec3 diffuse3 = Kd3 * (LightColor3 * LightBrightness3) * DiffuseProduct;
	
    float Ks1 = pow( max(dot(N, H1), 0.0), Shininess );
    float Ks2 = pow( max(dot(N, H2), 0.0), Shininess );
    float Ks3 = pow( max(dot(N, H3), 0.0), Shininess );
    
    vec3 specular1 = Ks1 * LightBrightness1 * SpecularProduct;
	vec3 specular2 = Ks2 * LightBrightness2 * SpecularProduct;
	vec3 specular3 = Ks3 * LightBrightness3 * SpecularProduct;
    
    if (dot(L1, N) < 0.0 ) {
	specular1 = vec3(0.0, 0.0, 0.0);
    } 
    
    if (dot(L2, N) < 0.0 ) {
	specular2 = vec3(0.0, 0.0, 0.0);
    }
    if (dot(L2, N) < 0.0 ) {
	specular3 = vec3(0.0, 0.0, 0.0);
    }
    
    // globalAmbient is independent of distance from the light source
    vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
    
    
    if(dot(normalize(Lvec3), normalize(lightPoint.xyz)) < cos(radians(30))){ 
    ambient3 = vec3(0.0, 0.0, 0.0);
	diffuse3 = vec3(0.0, 0.0, 0.0);
	specular3 = vec3(0.0, 0.0, 0.0);
}
    
    //CHANGE THIS!
    float len = 0.01 + length(Lvec1)/2.0;
    float len3 = length(Lvec3);
    
    vec3 color3 = ambient3 + diffuse3;
	vec4 color = vec4(globalAmbient +((ambient1 + diffuse1) / len) + ambient2 + diffuse2 + color3, 1.0);
	gl_FragColor = color * texture2D(texture, texCoord * texScale) + vec4((specular1 / len) +specular2, 1.0);
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*vec4 color1= vec4(globalAmbient +(ambient1 + diffuse1 + specular1)/(length(Lvec1)*length(Lvec1)),1.0)* texture2D( texture, texCoord * texScale );
	
	vec4 color2= vec4(globalAmbient +(ambient2 + diffuse2 + specular2)/(length(Lvec2)*length(Lvec2)),1.0)* texture2D( texture, texCoord * texScale );
	
	vec4 color3= vec4(globalAmbient +(ambient2 + diffuse2 + specular2)/(length(Lvec2)*length(Lvec2)),1.0)* texture2D( texture, texCoord * texScale );
	
    gl_FragColor = color1+color2;*/
}
