﻿Shader "0_Standard/Simple_Basic_NoShadow" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0	
	}
	SubShader {		
		Fog{mode off}
		Tags { "RenderType"="Opaque" "ForceNoShadowCasting"="True" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		fixed4 _EmissionColorCustom;
		
		void surf (Input IN, inout SurfaceOutputStandard o) 
		{		
			o.Albedo = fixed4(_Color.r,_Color.g,_Color.b,1) ;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			
		}		
		ENDCG
	} 
	FallBack "Diffuse"
}
