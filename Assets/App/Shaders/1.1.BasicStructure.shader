Shader "Unlit/BasicStructure"
{
    Properties
    {
        // User defined properties (Input data)
        _Value ("Value", Float) = 1.0

        // Available Data Types:
        // bool (0 or 1)
        // int
        // float, float2, float3, float4 (32-bit)
        // half, half2, half3, half4 (16-bit)
        // fixed, fixed2, fixed3, fixed4 (12-bit, depends on platform, almost not used)
        // To define matrix use this notation => float4x4
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 100

        Pass
        {
            // Technically Unity use HLSL, could be HLSL Program, CG is kind of heritage from nVidia CG language
            CGPROGRAM
            // Defines what function is vertex or fragment shader
            #pragma vertex vert
            #pragma fragment frag

            // Make fog work
            #pragma multi_compile_fog

            // Includes Unity specific implementations into your shader
            #include "UnityCG.cginc"

            // Variables that will be used in shader code, user defined properties must have coresponding vars
            float _Value;

            // Default name (appdata) is confusing, renamed to MeshData
            // Mesh Data is always per vertex
            struct MeshData
            {
                // Predefined options to get data from Mesh
                float4 vertex : POSITION; // Vertex position
                float3 normals : NORMAL;
                float4 tangent : TANGENT;
                float4 color : COLOR;
                float2 uv0 : TEXCOORD0; // UV coordinates, TEXCORD0 referc to UV channel 0
                float2 uv1 : TEXCOORD1; // You can use float4 to get more data
            };

            // Default name (v2f) is confusing, renamed to Interpolators
            // We pass data from vertex to fragment via Interpolators structure
            // Interpolators does make sence because data is allways interpolated inbetween to be rendered as pixels
            struct Interpolators
            {
                float4 vertex : SV_POSITION; // SV means Clip Space position of each vertex
                float2 uv : TEXCOORD0; // Here TEXCORD0 is not relates to UV it is just a Slot for data 
            };

            // Vertex Shader
            // Function that takes MeshData as input, Interpolates it and return
            Interpolators vert(MeshData v)
            {
                Interpolators o;
                // Vertex interpolators
                o.vertex = UnityObjectToClipPos(v.vertex); // Converts Local space to Clip space
                o.uv = float2(0, 0); // Initialize uv to a default value
                return o;
            }

            // Fragment Shader
            // Function that takes interpolated data and return actual color
            fixed4 frag(Interpolators i) : SV_Target // SV_Target means it outputs to Frame Buffer as target
            {
                return float4(1, 0, 0, 0); // return red color
            }
            ENDCG
        }
    }
}