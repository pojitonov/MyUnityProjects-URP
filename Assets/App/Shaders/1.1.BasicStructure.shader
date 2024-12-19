Shader "_Shaders/Unlit1.1"
{
    Properties
    {
        // PROPERTIES
        _Color ("Color", Color) = (1,0,0,0)
        _Color ("Color", Float) = (1,0,0,0)
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            // VARIABLES
            float4 _Color;

            struct Attributes
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
            };

            // VERTEX SHADER
            Interpolators vert(Attributes v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = v.normal;
                return o;
            }

            // FRAGMENT SHADER
            float4 frag(Interpolators i) : SV_Target
            {
                return float4(i.normal, 1);
            }
            ENDCG
        }
    }
}