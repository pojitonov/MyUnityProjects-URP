Shader "_Shaders/Unlit1.2"
{
    Properties
    {
        // PROPERTIES
        _ColorA ("ColorA", Color) = (0,0,0,0)
        _ColorB ("ColorB", Color) = (1,0,0,0)
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
            float4 _ColorA;
            float4 _ColorB;

            struct Attributes
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv : TEXCOORD0;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            // VERTEX SHADER
            Interpolators vert(Attributes v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }

            // FRAGMENT SHADER
            float4 frag(Interpolators i) : SV_Target
            {
                float4 outColor = lerp(_ColorA, _ColorB, i.uv.x);
                return outColor;
            }
            ENDCG
        }
    }
}