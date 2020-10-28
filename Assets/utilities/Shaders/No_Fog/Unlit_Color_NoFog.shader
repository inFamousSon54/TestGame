Shader "NoFog/Unlit_Color_NoFog"
{     
    Properties {
        _Color ("Color", Color) = (1,1,1)
    }
     
    SubShader {
    	Fog{Mode off}
    	cull off
        Color [_Color]
        Pass {


        }
    }
     
    }
