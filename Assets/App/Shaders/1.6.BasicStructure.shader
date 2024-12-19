Shader "_Shaders/Unlit1.6"
{
    Properties
    {
        // PROPERTIES
        _Value ("Value", Float) = 1
    }
    SubShader
    {
        Tags
        {
            // SUB-SHADER TAGS
            "RenderType"="Opaque"
        }
        Pass
        {
            // PASS TAGS
            ZWrite Off
            Cull Front
            Blend One One
            
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "Packages/com.timurproko.mytools/Assets/Shaders/MyTools.cginc"
            #pragma vertex Vertex
            #pragma fragment Fragment

            // VARIABLES
            float _Value;

            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normal : NORMAL;
                float4 uv : TEXCOORD0;
            };

            struct Interpolators
            {
                float4 positionCS : SV_POSITION;
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            // VERTEX SHADER
            Interpolators Vertex(Attributes IN)
            {
                Interpolators OUT;
                OUT.positionCS = UnityObjectToClipPos(IN.positionOS);
                OUT.normal = UnityObjectToWorldNormal(IN.normal);
                OUT.uv = IN.uv;
                return OUT;
            }

            // FRAGMENT SHADER
            float4 Fragment(Interpolators IN) : SV_Target
            {
                float time = _Time.y * _Value;
                float xOffset = cos(IN.uv.x * TAU * 8) * 0.01;
                float OUT = cos((IN.uv.y + xOffset - time) * TAU * 8) * 0.5 + 0.5;
                OUT *= IN.uv.y;
                OUT *= abs(IN.normal.y) < 0.999;
                return OUT;
            }
            ENDCG
        }
    }
}