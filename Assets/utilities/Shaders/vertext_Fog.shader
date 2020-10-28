// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/vertextFog"
{
	SubShader
	{
		Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Lighting Off
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite On
		Cull Off

		Pass 
		{
			AlphaTest Greater .25

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			 #pragma multi_compile_fog  


			#include "UnityCG.cginc"

			 sampler2D _MainTex;
			float4 _Color;
			float _Scale;

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
			};

			struct v2f
			{

				float4 pos : SV_POSITION;
				float4 color : COLOR;
				UNITY_FOG_COORDS(1)
			};

			v2f vert (appdata v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
	
	   		   UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}

			half4 frag (v2f i) : COLOR
			{
//			  half4 col = half4(1,0,0,1);
			  half4 col = i.color ;
//			    half4 col = null ;
//			 fixed4 col = tex2D(_MainTex, i.texcoord);
			   UNITY_APPLY_FOG(i.fogCoord,col);
//				return i.color ;
				return col 	;

			}

			ENDCG
		}
	}
}