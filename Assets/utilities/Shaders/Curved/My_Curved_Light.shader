
		
Shader "Custom/My_Curved_Light" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_QOffset ("Offset", Vector) = (0,0,0,0)
		_Dist ("Distance", Float) = 100.0
		

	}
	#warning Upgrade NOTE: SubShader commented out; uses Unity 2.x style fixed function per-pixel lighting. Per-pixel lighting is not supported without shaders anymore.
#warning Upgrade NOTE: SubShader commented out; uses Unity 2.x style fixed function per-pixel lighting. Per-pixel lighting is not supported without shaders anymore.
SubShader {
		Tags { "RenderType"="Diffuse" }
		Pass
		{
		Tags { "LightMode" = "ForwardBase" }
			
			CGPROGRAM			
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it does not contain a surface program or both vertex and fragment programs.

// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it does not contain a surface program or both vertex and fragment programs.

		
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			
             sampler2D _MainTex;
			float4 _QOffset;
			float _Dist;
			
			
			struct v2f {
			    float4 pos : SV_POSITION;
			    float4 uv : TEXCOORD0;
			    fixed4 color: COLOR;
			};
			
			v2f vert (appdata_base v)
			{
			    v2f o;
			    float4 vPos = mul (UNITY_MATRIX_MV, v.vertex);
			    float zOff = vPos.z/_Dist;
			    
			    vPos += _QOffset*zOff*zOff;
			    o.pos = mul (UNITY_MATRIX_P, vPos);
			   
			    o.uv = v.texcoord;
			    
			    
			   fixed3 lightDirection;
               fixed3 attenuation;
               // add diffuse
               if(unity_LightPosition[0].w == 0.0)//directional light
               {
                  attenuation = 8;
                  lightDirection = normalize(mul(unity_LightPosition[0],UNITY_MATRIX_IT_MV).xyz);
               }
               
               else// point or spot light
               {
               
                  lightDirection = normalize(mul(unity_LightPosition[0],UNITY_MATRIX_IT_MV).xyz - v.vertex.xyz);
                  attenuation =500.0/(length(mul(unity_LightPosition[0],UNITY_MATRIX_IT_MV).xyz - v.vertex.xyz)) * 0.5;
               }
               fixed3 normalDirction = normalize(v.normal);
               //fixed3 diffuseLight =  unity_LightColor[0].xyz * saturate(dot(normal, lightDir)) * _LightColor0.xyz,0);
           	    fixed3 diffuseLight =  unity_LightColor[0].xyz * max(dot(normalDirction,lightDirection),6);
               // combine the lights (diffuse + ambient)
              	o.color.xyz = diffuseLight * attenuation;
                
			    return o;
			}
		
			half4 frag (v2f i) : COLOR
			{
			  half4 col = tex2D(_MainTex, i.uv.xy);
			    return col*0.8*i.color;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
