// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

 Shader "Custom/Gradient_3Color_Stencil" {
     Properties {
         [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
         _ColorTop ("Top Color", Color) = (1,1,1,1)
         _ColorMid ("Mid Color", Color) = (1,1,1,1)
         _ColorBot ("Bot Color", Color) = (1,1,1,1)
         _Middle ("Middle", Range(0.001, 0.999)) = 1
         [IntRange] _StencilRef ("Stencil Reference Value", Range(0,255)) = 0
         	[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Int) = 3
     }
 
     SubShader {      

	
         Tags {"Queue"="Background"  "IgnoreProjector"="True" "LightMode" = "ForwardBase" }
         LOD 200
 
         ZWrite off
 	Blend SrcAlpha OneMinusSrcAlpha
         Pass {

             	Stencil 
		{
			Ref  [_StencilRef]
			Comp [_StencilComp]
            Pass Replace
            Fail Keep
		}

         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag 
         #include "UnityCG.cginc"
   #pragma multi_compile_fwdbase
   #include "AutoLight.cginc"
         fixed4 _ColorTop;
         fixed4 _ColorMid;
         fixed4 _ColorBot;
         float  _Middle;
 
         struct v2f {
             float4 pos : SV_POSITION;
             float4 texcoord : TEXCOORD0;
              LIGHTING_COORDS(0,1)
         };
 
         v2f vert (appdata_full v) {
             v2f o;
             o.pos = UnityObjectToClipPos (v.vertex);
             o.texcoord = v.texcoord;
              TRANSFER_VERTEX_TO_FRAGMENT(o);
             return o;
         }
 
         fixed4 frag (v2f i) : COLOR {
             fixed4 c = lerp(_ColorBot, _ColorMid, i.texcoord.y / _Middle) * step(i.texcoord.y, _Middle);
             c += lerp(_ColorMid, _ColorTop, (i.texcoord.y - _Middle) / (1 - _Middle)) * step(_Middle, i.texcoord.y);
             c.a = 1;
               float attenuation = LIGHT_ATTENUATION(i);              
             return c*attenuation;
         }
         ENDCG
         }
     }
        Fallback "VertexLit"
 }