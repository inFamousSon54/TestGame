Shader "SimpleStandard_Transparent" {
 Properties {
     _Color ("Main Color", Color) = (1,1,1,1)
     _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
     
     _BrightNess("BrightNess", Float) = 0.0
	_OverallBrightNess("OverallBrightNess", Float) = 0.0
 }
 
 SubShader {
     Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
     LOD 200
 
 CGPROGRAM
 #pragma surface surf Lambert alpha
 
 sampler2D _MainTex;
 fixed4 _Color;
 
 struct Input {
     float2 uv_MainTex;
 };
 
 		float _BrightNess ;
		float _OverallBrightNess ;
 
 void surf (Input IN, inout SurfaceOutput o) {
     fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
     
     	o.Albedo = fixed4(_Color.r + ((1-_Color.r) *_BrightNess) ,_Color.g + ((1-_Color.g) *_BrightNess) ,_Color.b,1) * c.rgb +  (c.rgb*_OverallBrightNess);
     	
//     o.Albedo = c.rgb;
     o.Alpha = c.a;
 }
 ENDCG
 }
 
 Fallback "Transparent/VertexLit"
 }
