// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/StandardSimpleCutout"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_EmissiveColor("Emissive Color", Color) = (1,1,1,0)
		_EmissivePower("Emissive Power", Float) = 0
		_BaseColor("Base Color", Color) = (1,1,1,0)
		_AlbetoMap("Albeto Map", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_DetailedNormalMap("Detailed Normal Map", 2D) = "bump" {}
		_DetailedNormalUV("Detailed Normal UV", Float) = 1
		_DetailedNormalAmount("Detailed Normal Amount", Float) = 1
		_CompactMap("Compact Map", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Roughtness("Roughtness", Range( 0 , 2)) = 1
		_AmbientOcclusion("Ambient Occlusion", Range( 0 , 1)) = 1
		_VertexColoring("Vertex Coloring", Float) = 0.3
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+3" }
		Cull Back
		Stencil
		{
			Ref 0
		}
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 4.0
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_NormalMap;
			float2 texcoord_0;
			float2 uv_AlbetoMap;
			float4 vertexColor : COLOR;
			float2 uv_CompactMap;
		};

		struct SurfaceOutputStandardCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			fixed3 Transmission;
			fixed3 Translucency;
		};

		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform float _DetailedNormalAmount;
		uniform sampler2D _DetailedNormalMap;
		uniform float _DetailedNormalUV;
		uniform float4 _BaseColor;
		uniform float _VertexColoring;
		uniform sampler2D _AlbetoMap;
		uniform float4 _EmissiveColor;
		uniform float _EmissivePower;
		uniform sampler2D _CompactMap;
		uniform float _Metalic;
		uniform float _Roughtness;
		uniform float _AmbientOcclusion;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			UNITY_GI(gi, s, data);
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			o.Normal = ( UnpackScaleNormal( tex2D( _NormalMap,i.uv_NormalMap) ,_NormalScale ) + ( UnpackScaleNormal( tex2D( _DetailedNormalMap,( i.texcoord_0 * _DetailedNormalUV )) ,_DetailedNormalAmount ) * 1.0 ) );
			float4 temp_cast_1 = _VertexColoring;
			float4 tex2DNode2 = tex2D( _AlbetoMap,i.uv_AlbetoMap);
			o.Albedo = ( _BaseColor * lerp( temp_cast_1 , tex2DNode2 , i.vertexColor.r ) ).xyz;
			o.Emission = ( ( _EmissiveColor * _EmissivePower ) * tex2DNode2 ).xyz;
			float4 tex2DNode10 = tex2D( _CompactMap,i.uv_CompactMap);
			o.Metallic = ( tex2DNode10.r * _Metalic );
			o.Smoothness = ( tex2DNode10.g * _Roughtness );
			o.Occlusion = ( tex2DNode10.b * _AmbientOcclusion );
			float3 temp_cast_5 = tex2DNode2.a;
			o.Transmission = temp_cast_5;
			float3 temp_cast_6 = tex2DNode2.a;
			o.Translucency = temp_cast_6;
			o.Alpha = tex2DNode2.a;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
-1909;37;1906;1004;1199.697;369.1998;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;41;-806.7007,-891.8999;Float;575;452;Emissive Settings;4;40;37;38;39
Node;AmplifyShaderEditor.CommentaryNode;36;-836.6006,291.4;Float;690.4803;540.44;Metalic, Smoothness and AO Setup;7;10;13;12;11;14;15;16
Node;AmplifyShaderEditor.CommentaryNode;35;-2366.211,-27.49994;Float;1504.519;621.3105;Normal Setup;10;43;44;42;45;50;7;5;51;53;52
Node;AmplifyShaderEditor.CommentaryNode;34;-808.0003,-415.3002;Float;574.3201;421.8598;Alberto Setup;3;32;33;2
Node;AmplifyShaderEditor.SamplerNode;5;-1630.4,17.6;Float;Property;_NormalMap;Normal Map;4;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-316,706.6999;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-313,538.6999;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-315,411.7;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;11;-741,531.6999;Float;Property;_Metalic;Metalic;10;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;12;-741,618.6999;Float;Property;_Roughtness;Roughtness;11;1;0;2
Node;AmplifyShaderEditor.RangedFloatNode;13;-744,718.6999;Float;Property;_AmbientOcclusion;Ambient Occlusion;12;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;7;-1865.4,129.6;Float;Property;_NormalScale;Normal Scale;5;1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-371.9,-236.1;Float;COLOR;0.0,0,0,0;FLOAT4;0,0,0,0
Node;AmplifyShaderEditor.ColorNode;32;-671.9,-358.1;Float;Property;_BaseColor;Base Color;2;1,1,1,0
Node;AmplifyShaderEditor.RangedFloatNode;38;-747.7007,-587.8999;Float;Property;_EmissivePower;Emissive Power;1;0;0;0
Node;AmplifyShaderEditor.ColorNode;37;-771.7007,-827.8999;Float;Property;_EmissiveColor;Emissive Color;0;1,1,1,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-525.7007,-745.8999;Float;COLOR;0.0,0,0,0;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-368.7007,-614.8999;Float;COLOR;0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;10;-747.4999,330.5999;Float;Property;_CompactMap;Compact Map;9;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-1060.599,100.8006;Float;FLOAT3;0,0,0;FLOAT3;0.0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1165.4,364.8004;Float;FLOAT3;0.0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.SamplerNode;42;-1543,259.2003;Float;Property;_DetailedNormalMap;Detailed Normal Map;6;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1661.4,476.8004;Float;Constant;_Default;Default;12;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;43;-1872.6,340.8002;Float;Property;_DetailedNormalAmount;Detailed Normal Amount;8;1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-2060.899,234.0007;Float;FLOAT2;0.0,0;FLOAT;0.0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-2292.699,62.80069;Float;0;-1;FLOAT2;1,1;FLOAT2;0,0
Node;AmplifyShaderEditor.RangedFloatNode;52;-2301.299,330.6007;Float;Property;_DetailedNormalUV;Detailed Normal UV;7;1;0;0
Node;AmplifyShaderEditor.VertexColorNode;54;-1385.598,-276.3994;Float
Node;AmplifyShaderEditor.LerpOp;56;-1093.098,-362.1995;Float;FLOAT;0.0;FLOAT4;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1384.299,-380.3995;Float;Property;_VertexColoring;Vertex Coloring;13;0.3;0;0
Node;AmplifyShaderEditor.SamplerNode;2;-766,-177;Float;Property;_AlbetoMap;Albeto Map;3;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;4;Float;ASEMaterialInspector;Standard;PolyPixel/StandardSimpleCutout;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Masked;-0.31;True;True;3;True;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
WireConnection;5;5;7;0
WireConnection;16;0;10;3
WireConnection;16;1;13;0
WireConnection;15;0;10;2
WireConnection;15;1;12;0
WireConnection;14;0;10;1
WireConnection;14;1;11;0
WireConnection;33;0;32;0
WireConnection;33;1;56;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;40;0;39;0
WireConnection;40;1;2;0
WireConnection;50;0;5;0
WireConnection;50;1;45;0
WireConnection;45;0;42;0
WireConnection;45;1;44;0
WireConnection;42;1;51;0
WireConnection;42;5;43;0
WireConnection;51;0;53;0
WireConnection;51;1;52;0
WireConnection;56;0;55;0
WireConnection;56;1;2;0
WireConnection;56;2;54;1
WireConnection;0;0;33;0
WireConnection;0;1;50;0
WireConnection;0;2;40;0
WireConnection;0;3;14;0
WireConnection;0;4;15;0
WireConnection;0;5;16;0
WireConnection;0;6;2;4
WireConnection;0;7;2;4
WireConnection;0;8;2;4
WireConnection;0;9;2;4
ASEEND*/
//CHKSM=E99D7F7141F81498AD02880201E1527744F5E2E0