﻿Shader "0_Standard/Simple_NoFog_Shadow" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Global_Brightness("Global Brightness", Float) = 0.0
	}
	SubShader {
		Fog{mode off}
		Tags { "RenderType"="Opaque"}
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows nofog		
		#pragma target 3.0
		sampler2D _MainTex;
		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		fixed4 _EmissionColorCustom;	
		float _Global_Brightness ;	
		
		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color ;
			o.Albedo = c.rgb*_Global_Brightness;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}		
		ENDCG
	} 
	FallBack "Diffuse"
}
