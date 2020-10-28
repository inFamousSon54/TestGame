Shader "Custom/My_Curved_Particle" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_QOffset ("Offset", Vector) = (0,0,0,0)
		_Dist ("Distance", Float) = 100.0
		_Cutoff ("Alpha Cutoff", Float) = 0.5
	}
	SubShader {
		Tags {"Queue"="Transparent" "RenderType"="Transparent" }
		Pass
		{
		 
		 // Cull Front 
		  Blend SrcAlpha OneMinusSrcAlpha 
		  ZWrite Off

		  //AlphaTest Greater [_Cutoff] 
		CGPROGRAM		
		
			#pragma vertex vert
			#pragma fragment frag		
			
#pragma multi_compile_builtin
#pragma fragmentoption ARB_fog_exp2
#pragma fragmentoption ARB_precision_hint_fastest
#pragma multi_compile_fwdadd


			#include "UnityCG.cginc"		
            #include "AutoLight.cginc" 
            
                        
             sampler2D _MainTex;
			float4 _QOffset;
			float _Dist;
			
			struct v2f {
			    float4 pos : SV_POSITION;
			    float4 uv : TEXCOORD0;
			};
			
			v2f vert (appdata_base v)
			{
			    v2f o;
			    float4 vPos = mul (UNITY_MATRIX_MV, v.vertex);
			    float zOff = vPos.z/_Dist;
			    vPos += _QOffset*zOff*zOff;
			    o.pos = mul (UNITY_MATRIX_P, vPos);
			    o.uv = v.texcoord;
			    return o;
			}		


 			
            
			half4 frag (v2f i) : COLOR
			{
				float3 lightColor = UNITY_LIGHTMODEL_AMBIENT.xyz;
		   		 half4 col = tex2D(_MainTex,i.uv.xy);
			   
			     if (col.a <= 0)
           		 {
           	 		 discard; 
           	 			 
           	 		  return col*0;
            	}
            	else
            	{
            	
			    return col*2;
			    }
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
