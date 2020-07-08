#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor; // assigns the final pixel color
  
  // Try changing the value of vertColor in the fragment shader to see what effect it has
  // on the final pixel color. e.g you could do vertColor = vec4(0,1,0,1);
}
