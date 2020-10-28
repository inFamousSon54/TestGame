// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/substraction shader"
{
   Properties {
     _Texture0 ("Texture 0", 2D) = "Texture1" {}
 }

 SubShader {

     Tags {"Queue" = "Geometry"}

     Pass {

         Cull Off
         ZTest Off
         ZWrite On
         AlphaTest Off
         Lighting Off
         ColorMask RGBA
         BlendOp Sub
         Blend One One

         CGPROGRAM
         #pragma target 2.0
         #pragma fragment frag
         #pragma vertex vert
         #include "UnityCG.cginc"

         uniform sampler2D _Texture0;
         uniform float4 _Texture0_ST;

         struct AppData {
             float4 vertex : POSITION;
             half2 texcoord : TEXCOORD0;
         };

         struct VertexToFragment {
             float4 pos : POSITION;
             half2 uv : TEXCOORD0;
         };

         VertexToFragment vert(AppData v) {
             VertexToFragment o;
             o.pos = UnityObjectToClipPos(v.vertex);
             o.uv = v.texcoord.xy;
             return o;
         }

         fixed4 frag(VertexToFragment i) : COLOR {
             return fixed4(tex2D(_Texture0, i.uv));
         }

         ENDCG

     }
 }
}
