Shader "Standard_Mask_Stencil" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0		
		_BrightNess("BrightNess", Float) = 0.0
		_OverallBrightNess("OverallBrightNess", Float) = 0.0
		[IntRange] _ColorMask ("Color Mask", Range(0,255)) = 255
		[IntRange] _StencilRef ("Stencil Reference Value", Range(0,255)) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Int) = 3
	}
	SubShader {		
		Fog{mode off}
		ColorMask [_ColorMask]
		Tags { "RenderType"="Opaque"}
		LOD 200
		

		Stencil 
		{
			Ref  [_StencilRef]
			Comp [_StencilComp]
			Pass Replace
			Fail Keep
		}
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
		//		float _BrightNess
		float _BrightNess ;
		float _OverallBrightNess ;
		
		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex)  ;
			o.Albedo = fixed4(_Color.r + ((1-_Color.r) *_BrightNess) ,_Color.g + ((1-_Color.g) *_BrightNess) ,_Color.b,1) * c.rgb +  (c.rgb*_OverallBrightNess);
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}		
		ENDCG
		
	} 
	FallBack "Diffuse"
}
