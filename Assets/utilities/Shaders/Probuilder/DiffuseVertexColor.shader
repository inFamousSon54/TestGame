Shader "ProBuilder/Diffuse Vertex Color" {
  Properties {
    _MainTex ("Texture", 2D) = "white" {}
  }
  SubShader {
  Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	ZWrite Off
	Alphatest Greater 0
   Blend SrcAlpha OneMinusSrcAlpha 
  
   
    CGPROGRAM
 
    
    #pragma surface surf Lambert

    sampler2D _MainTex;
	
    struct Input {
        float4 color : COLOR;
        float2 uv_MainTex;
    };

    void surf (Input IN, inout SurfaceOutput o) {
        fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * IN.color;
        o.Albedo = c.rgb;
        o.Alpha = IN.color.a ;
    }
    ENDCG
  }

  Fallback "Diffuse"
}
