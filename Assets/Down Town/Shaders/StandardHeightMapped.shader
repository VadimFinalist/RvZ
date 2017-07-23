// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/StandardHeightPOM"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Tiling("Tiling", Float) = 2
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 0.5
		_CompactMap("Compact Map", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.7
		_Occlusion("Occlusion", Range( 0 , 1)) = 1
		_HeightMap("HeightMap", 2D) = "white" {}
		_Scale("Scale", Range( 0 , 1)) = 0.4247461
		_CloudMap("Cloud Map", 2D) = "white" {}
		_RainFallAmount("RainFall Amount", Float) = 0
		_PuddleColor("Puddle Color", Color) = (0.5147059,0.5147059,0.5147059,0)
		_PuddleSize("Puddle Size", Float) = 0
		_PuddleFalloff("Puddle Falloff", Float) = 0
		_PuddleAmount("Puddle Amount", Range( 0 , 3)) = 0
		_PuddleReflectionAmount("Puddle Reflection Amount", Range( 0 , 1)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+1" }
		Cull Back
		ZTest LEqual
		Stencil
		{
			Ref 0
		}
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 4.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_Albedo;
			float3 viewDir;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldViewDir;
			float2 uv_Normal;
			float3 worldPos;
		};

		uniform float _Tiling;
		uniform sampler2D _HeightMap;
		uniform float _Scale;
		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform float _PuddleAmount;
		uniform sampler2D _CloudMap;
		uniform float _PuddleSize;
		uniform float _RainFallAmount;
		uniform float _PuddleFalloff;
		uniform sampler2D _Albedo;
		uniform float4 _PuddleColor;
		uniform sampler2D _CompactMap;
		uniform float _Metalic;
		uniform float _Smoothness;
		uniform float _PuddleReflectionAmount;
		uniform float _Occlusion;


		inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling )
		{
			int stepIndex = 0;
			int numSteps = ( int )lerp( maxSamples, minSamples, length( fwidth( uvs ) ) * 10 );
			float layerHeight = 1.0 / numSteps;
			float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
			uvs += refPlane * plane;
			float2 deltaTex = -plane * layerHeight;
			float2 prevTexOffset = 0;
			float prevRayZ = 1.0f;
			float prevHeight = 0.0f;
			float2 currTexOffset = deltaTex;
			float currRayZ = 1.0f - layerHeight;
			float currHeight = 0.0f;
			float intersection = 0;
			float2 finalTexOffset = 0;
			while ( stepIndex < numSteps + 1 )
			{
				currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				if ( currHeight > currRayZ )
				{
					stepIndex = numSteps + 1;
				}
				else
				{
					stepIndex++;
					prevTexOffset = currTexOffset;
					prevRayZ = currRayZ;
					prevHeight = currHeight;
					currTexOffset += deltaTex;
					currRayZ -= layerHeight;
				}
			}
			int sectionSteps = 5;
			int sectionIndex = 0;
			float newZ = 0;
			float newHeight = 0;
			while ( sectionIndex < sectionSteps )
			{
				intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				finalTexOffset = prevTexOffset + intersection * deltaTex;
				newZ = prevRayZ - intersection * layerHeight;
				newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				if ( newHeight > newZ )
				{
					currTexOffset = finalTexOffset;
					currHeight = newHeight;
					currRayZ = newZ;
					deltaTex = intersection * deltaTex;
					layerHeight = intersection * layerHeight;
				}
				else
				{
					prevTexOffset = finalTexOffset;
					prevHeight = newHeight;
					prevRayZ = newZ;
					deltaTex = ( 1 - intersection ) * deltaTex;
					layerHeight = ( 1 - intersection ) * layerHeight;
				}
				sectionIndex++;
			}
			return uvs + finalTexOffset;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.worldViewDir = normalize( _WorldSpaceCameraPos - v.vertex );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_50_0 = ( _Tiling * i.uv_Albedo );
			float2 OffsetPOM8 = POM( _HeightMap, temp_output_50_0, ddx(temp_output_50_0), ddx(temp_output_50_0), WorldNormalVector( i, float3( 0, 0, 1 ) ), i.worldViewDir, i.viewDir, 64, 64, _Scale, 0, float2(1.0, 1.0) );
			float2 customUVs = OffsetPOM8;
			float2 temp_output_40_0 = ddx( temp_output_50_0 );
			float2 temp_output_41_0 = ddy( temp_output_50_0 );
			float cos90 = cos( 0.1 );
			float sin90 = sin( 0.1 );
			float2 rotator90 = mul(( _PuddleSize * i.worldPos.xz ) - float2( 0.5,0.5 ), float2x2(cos90,-sin90,sin90,cos90)) + float2( 0.5,0.5 );
			float temp_output_80_0 = ( _PuddleAmount * clamp( lerp( -2.0 , 1 , pow( tex2D( _CloudMap,rotator90).r , ( _RainFallAmount / _PuddleFalloff ) ) ) , 0.0 , 1.0 ) );
			o.Normal = lerp( UnpackScaleNormal( tex2D( _Normal,customUVs, temp_output_40_0, temp_output_41_0) ,_NormalScale ) , UnpackNormal( tex2D( _Normal,i.uv_Normal) ) , temp_output_80_0 );
			float4 tex2DNode11 = tex2D( _Albedo,customUVs, temp_output_40_0, temp_output_41_0);
			o.Albedo = lerp( tex2DNode11 , ( tex2DNode11 * _PuddleColor ) , temp_output_80_0 ).rgb;
			float2 temp_cast_3 = 1.0;
			float4 tex2DNode23 = tex2D( _CompactMap,temp_cast_3, temp_output_40_0, temp_output_41_0);
			o.Metallic = ( tex2DNode23.r * _Metalic );
			o.Smoothness = lerp( ( tex2DNode23.g * _Smoothness ) , _PuddleReflectionAmount , temp_output_80_0 );
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
219;32;1158;915;467.0959;340.8688;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;109;-3294.932,-1655.601;Float;2888.511;910.4003;Puddles Basic Setup;15;78;80;79;70;69;91;74;64;90;66;65;60;67;68;61
Node;AmplifyShaderEditor.CommentaryNode;55;-214.6332,-1102.902;Float;604.3202;565.9199;Albedo Settings;3;11;111;100
Node;AmplifyShaderEditor.CommentaryNode;54;-230.6331,-472.502;Float;640.16;494.2401;Normal Settings;3;24;14;114
Node;AmplifyShaderEditor.CommentaryNode;53;-209.8331,50.6979;Float;747.6801;573.6;Metalic, Smoothness and AO Setup;8;51;23;45;44;43;48;47;46
Node;AmplifyShaderEditor.CommentaryNode;52;-1703.532,-364.3021;Float;1326.239;755.3596;Parallax Oclussion Mapping Settings;10;39;41;40;10;49;50;8;13;9;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;353.6661,310.4981;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;357.6661,413.4982;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;357.6661,512.4982;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;44;51.66606,392.4982;Float;Property;_Smoothness;Smoothness;6;0.7;0;1
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;15;-1107.999,87.09995;Float;Tangent
Node;AmplifyShaderEditor.TexturePropertyNode;9;-1548.999,-82.90001;Float;Property;_HeightMap;HeightMap;8;None;False;white;Auto
Node;AmplifyShaderEditor.RangedFloatNode;13;-1267.999,-4.900008;Float;Property;_Scale;Scale;9;0.4247461;0;1
Node;AmplifyShaderEditor.ParallaxOcclusionMappingNode;8;-858.5999,-104.5;Float;0;64;64;5;0.02;0;False;1,1;FLOAT2;0,0;SAMPLER2D;;FLOAT;0.0;FLOAT3;0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1075.133,-230.502;Float;FLOAT;0;FLOAT2;0.0,0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1273.133,-297.502;Float;Property;_Tiling;Tiling;0;2;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1319.999,-188.9;Float;0;11;FLOAT2;1,1;FLOAT2;0,0
Node;AmplifyShaderEditor.RangedFloatNode;51;-185.4337,242.398;Float;Constant;_MetalicMapUV;Metalic Map UV;10;1;0;0
Node;AmplifyShaderEditor.SamplerNode;14;36.70477,-403.4692;Float;Property;_Normal;Normal;2;None;True;0;True;bump;Auto;True;Object;-1;Derivative;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;24;-201.3284,-412.2736;Float;Property;_NormalScale;Normal Scale;3;0.5;0;0
Node;AmplifyShaderEditor.DdxOpNode;40;-553.7366,-235.5017;Float;FLOAT2;0.0,0
Node;AmplifyShaderEditor.DdyOpNode;41;-539.5367,-143.1018;Float;FLOAT2;0.0,0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-588.6807,-320.7194;Float;customUVs;1;FLOAT2;0.0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-2779.633,-1175.503;Float;FLOAT;0;FLOAT2;0.0,0
Node;AmplifyShaderEditor.RangedFloatNode;68;-2326.232,-942.9026;Float;Property;_RainFallAmount;RainFall Amount;11;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-2317.232,-831.9026;Float;Property;_PuddleFalloff;Puddle Falloff;14;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-3036.634,-1269.502;Float;Property;_PuddleSize;Puddle Size;13;0;0;0
Node;AmplifyShaderEditor.PowerNode;65;-1777.232,-1051.903;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleDivideOpNode;66;-2016.232,-922.9026;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RotatorNode;90;-2507.131,-1203.203;Float;FLOAT2;0,0;FLOAT2;0.5,0.5;FLOAT;0.0
Node;AmplifyShaderEditor.SamplerNode;64;-2244.232,-1228.903;Float;Property;_CloudMap;Cloud Map;10;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.ComponentMaskNode;74;-3057.132,-1118.503;Float;True;False;True;True;FLOAT3;0,0,0
Node;AmplifyShaderEditor.RangedFloatNode;91;-2769.532,-1067.003;Float;Constant;_Float0;Float 0;16;0.1;0;0
Node;AmplifyShaderEditor.LerpOp;69;-1602.732,-1221.903;Float;FLOAT;-2.0;FLOAT;1;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-1059.13,-1231.403;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.WorldPosInputsNode;78;-3267.931,-1184.003;Float
Node;AmplifyShaderEditor.LerpOp;72;463.3683,-474.1029;Float;FLOAT4;0.0,0,0,0;COLOR;0.6102941,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.ClampOpNode;70;-1375.532,-1223.902;Float;FLOAT;0.0;FLOAT;0.0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1357.83,-1354.103;Float;Property;_PuddleAmount;Puddle Amount;15;0;0;3
Node;AmplifyShaderEditor.RangedFloatNode;82;397.4689,-320.903;Float;Property;_PuddleReflectionAmount;Puddle Reflection Amount;16;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;43;55.66606,301.4981;Float;Property;_Metalic;Metalic;5;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;45;49.66606,489.4982;Float;Property;_Occlusion;Occlusion;7;1;0;1
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1446.705,-286.0693;Float;True;4;Float;ASEMaterialInspector;Standard;PolyPixel/StandardHeightPOM;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;1;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.LerpOp;81;758.6689,-273.303;Float;FLOAT;0.0;FLOAT;0.4411765;FLOAT;0.0
Node;AmplifyShaderEditor.LerpOp;110;486.1652,-120.4021;Float;FLOAT3;0.0,0,0;FLOAT3;1.0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.ColorNode;100;-191.231,-1021.201;Float;Property;_PuddleColor;Puddle Color;12;0.5147059,0.5147059,0.5147059,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;226.1653,-1000.901;Float;FLOAT4;0.0,0,0,0;COLOR;0.0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;11;-44.89521,-800.2692;Float;Property;_Albedo;Albedo;1;None;True;0;False;white;Auto;False;Object;-1;Derivative;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SamplerNode;114;-14.40003,-174.4;Float;Property;_BlankNormal;Blank Normal;17;None;True;0;False;bump;Auto;True;Instance;14;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SamplerNode;23;64.90477,116.3307;Float;Property;_CompactMap;Compact Map;4;None;True;0;False;white;Auto;False;Object;-1;Derivative;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
WireConnection;46;0;23;1
WireConnection;46;1;43;0
WireConnection;47;0;23;2
WireConnection;47;1;44;0
WireConnection;48;0;23;3
WireConnection;48;1;45;0
WireConnection;8;0;50;0
WireConnection;8;1;9;0
WireConnection;8;2;13;0
WireConnection;8;3;15;0
WireConnection;50;0;49;0
WireConnection;50;1;10;0
WireConnection;14;1;39;0
WireConnection;14;3;40;0
WireConnection;14;4;41;0
WireConnection;14;5;24;0
WireConnection;40;0;50;0
WireConnection;41;0;50;0
WireConnection;39;0;8;0
WireConnection;61;0;60;0
WireConnection;61;1;74;0
WireConnection;65;0;64;1
WireConnection;65;1;66;0
WireConnection;66;0;68;0
WireConnection;66;1;67;0
WireConnection;90;0;61;0
WireConnection;90;2;91;0
WireConnection;64;1;90;0
WireConnection;74;0;78;0
WireConnection;69;2;65;0
WireConnection;80;0;79;0
WireConnection;80;1;70;0
WireConnection;72;0;11;0
WireConnection;72;1;111;0
WireConnection;72;2;80;0
WireConnection;70;0;69;0
WireConnection;0;0;72;0
WireConnection;0;1;110;0
WireConnection;0;3;46;0
WireConnection;0;4;81;0
WireConnection;0;5;48;0
WireConnection;81;0;47;0
WireConnection;81;1;82;0
WireConnection;81;2;80;0
WireConnection;110;0;14;0
WireConnection;110;1;114;0
WireConnection;110;2;80;0
WireConnection;111;0;11;0
WireConnection;111;1;100;0
WireConnection;11;1;39;0
WireConnection;11;3;40;0
WireConnection;11;4;41;0
WireConnection;23;1;51;0
WireConnection;23;3;40;0
WireConnection;23;4;41;0
ASEEND*/
//CHKSM=F61F8BDE5C0D72968258A24DBEE4130F97462DB9