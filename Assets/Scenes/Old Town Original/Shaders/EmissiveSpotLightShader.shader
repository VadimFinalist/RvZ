// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/EmissiveSpotLightShader"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_BaseMap("Base Map", 2D) = "white" {}
		_LightColor("Light Color", Color) = (0.7519464,0.8430169,0.8970588,1)
		_EmissiveStrenght("Emissive Strenght", Float) = 7
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 0
		_MetalicMap("Metalic Map", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 0.5
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Occlusion("Occlusion", Range( 0 , 1)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+2" }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 4.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_NormalMap;
			float2 uv_BaseMap;
			float2 uv_MetalicMap;
		};

		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform sampler2D _BaseMap;
		uniform float4 _LightColor;
		uniform float _EmissiveStrenght;
		uniform sampler2D _MetalicMap;
		uniform float _Metalic;
		uniform float _Smoothness;
		uniform float _Occlusion;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue, 0, 0, 0,0,contrastValue, 0, 0,0,0,contrastValue, 0,t, t, t, 1 ), colorTarget );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap,i.uv_NormalMap) ,_NormalScale );
			float4 tex2DNode10 = tex2D( _BaseMap,i.uv_BaseMap);
			o.Albedo = tex2DNode10.xyz;
			float4 temp_cast_1 = 0.33;
			o.Emission = lerp( float4( 0,0,0,0 ) , ( _LightColor * _EmissiveStrenght ) , CalculateContrast(tex2DNode10.a,temp_cast_1).r ).rgb;
			float4 tex2DNode23 = tex2D( _MetalicMap,i.uv_MetalicMap);
			o.Metallic = ( tex2DNode23.r * _Metalic );
			o.Smoothness = ( tex2DNode23.g * _Smoothness );
			o.Occlusion = ( tex2DNode23.b * _Occlusion );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
125;29;1266;918;1345.862;469.7087;1.188773;True;True
Node;AmplifyShaderEditor.CommentaryNode;35;-859.6539,368.3763;Float;812.2433;458.9481;Metalic, Roughness and AO Setup;7;17;23;22;18;26;25;24
Node;AmplifyShaderEditor.CommentaryNode;34;-1011.817,130.6217;Float;632.7693;213.0546;Normal Settings;2;33;11
Node;AmplifyShaderEditor.CommentaryNode;32;-1161.546,-241.4643;Float;682.2307;343.0672;Albedo Settings;3;12;1;10
Node;AmplifyShaderEditor.CommentaryNode;31;-1009.102,-750.2594;Float;683.6438;492.8644;Light Emission Setup;5;27;14;15;28;16
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;4;Float;ASEMaterialInspector;Standard;PolyPixel/EmissiveSpotLightShader;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Opaque;0.5;True;True;2;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.LerpOp;13;-337.2029,-28.90922;Float;COLOR;0,0,0,0;COLOR;0.0,0,0,0;COLOR;0.0,0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-212.9469,671.5133;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-215.3244,568.0899;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-214.1356,464.6666;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;18;-505.1803,560.6955;Float;Property;_Smoothness;Smoothness;7;0;0;1
Node;AmplifyShaderEditor.RangedFloatNode;22;-504.1962,660.814;Float;Property;_Occlusion;Occlusion;8;1;0;1
Node;AmplifyShaderEditor.SamplerNode;23;-803.767,538.3704;Float;Property;_MetalicMap;Metalic Map;5;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;17;-507.2804,465.9181;Float;Property;_Metalic;Metalic;6;0.5;0;1
Node;AmplifyShaderEditor.ColorNode;14;-968.3729,-697.7902;Float;Property;_LightColor;Light Color;1;0.7519464,0.8430169,0.8970588,1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-588.0475,-629.2636;Float;COLOR;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;15;-952.5483,-493.5788;Float;Property;_EmissiveStrenght;Emissive Strenght;2;7;0;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-917.357,-392.4387;Float;Constant;_OffZero;OffZero;8;0;0;0
Node;AmplifyShaderEditor.SwitchNode;27;-598.766,-451.8773;Float;0;2;COLOR;0.0,0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SamplerNode;10;-1129.272,-176.313;Float;Property;_BaseMap;Base Map;0;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleContrastOpNode;1;-654.2958,-108.4488;Float;0;FLOAT;0.0;COLOR;0,0,0,0
Node;AmplifyShaderEditor.RangedFloatNode;12;-880.5604,9.720621;Float;Constant;_Float0;Float 0;2;0.33;0;0
Node;AmplifyShaderEditor.SamplerNode;11;-697.4888,177.1796;Float;Property;_NormalMap;Normal Map;3;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;33;-946.4343,235.2337;Float;Property;_NormalScale;Normal Scale;4;0;0;0
WireConnection;0;0;10;0
WireConnection;0;1;11;0
WireConnection;0;2;13;0
WireConnection;0;3;26;0
WireConnection;0;4;25;0
WireConnection;0;5;24;0
WireConnection;13;1;27;0
WireConnection;13;2;1;0
WireConnection;24;0;23;3
WireConnection;24;1;22;0
WireConnection;25;0;23;2
WireConnection;25;1;18;0
WireConnection;26;0;23;1
WireConnection;26;1;17;0
WireConnection;16;0;14;0
WireConnection;16;1;15;0
WireConnection;27;0;16;0
WireConnection;27;1;28;0
WireConnection;1;0;10;4
WireConnection;1;1;12;0
WireConnection;11;5;33;0
ASEEND*/
//CHKSM=94CDCC7C247AA497C26D04E226698D862619805F