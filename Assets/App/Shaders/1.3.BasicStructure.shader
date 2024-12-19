Shader "_Shaders/Unlit1.3"
{
    Properties
    {
        // PROPERTIES
        _ColorA ("ColorA", Color) = (0,0,0,0)
        _ColorB ("ColorB", Color) = (1,0,0,0)
        _ColorStart ("ColorStart", Range(0,1)) = 0
        _ColorEnd ("ColorEnd", Range(0,1)) = 1
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
            #include "UnityCG.cginc"
            #include "Packages/com.timurproko.mytools/Assets/Shaders/MyTools.cginc"
            #pragma vertex vert
            #pragma fragment frag

            // VARIABLES
            float4 _ColorA;
            float4 _ColorB;
            float _ColorStart;
            float _ColorEnd;

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
                float t = InverseLerp(_ColorStart, _ColorEnd, i.uv.x);
                t = Clamp01(t);
                float4 outColor = lerp(_ColorA, _ColorB, t);
                return outColor;
            }
            ENDCG
        }
    }
}