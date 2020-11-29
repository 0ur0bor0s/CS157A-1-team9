attribute vec4 aVertexPositition;
attribute vec4 aVertexColor;

uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
varying lowp vec4 vColor;

void main(void) {
  	gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;
  	vColor = aVertexColor;
}