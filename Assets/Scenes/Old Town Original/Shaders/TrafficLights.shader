// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/TrafficLights(TBC)"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_AlbedoMap("Albedo Map", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_MetalicMap("Metalic Map", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		_AmbientOcclusion("Ambient Occlusion", Range( 0 , 1)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+1" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_NormalMap;
			float2 uv_AlbedoMap;
			float2 uv_MetalicMap;
		};

		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform sampler2D _AlbedoMap;
		uniform sampler2D _MetalicMap;
		uniform float _Metalic;
		uniform float _Smoothness;
		uniform float _AmbientOcclusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap,i.uv_NormalMap) ,_NormalScale );
			float4 tex2DNode1 = tex2D( _AlbedoMap,i.uv_AlbedoMap);
			o.Albedo = ( float4(1,1,1,1) * tex2DNode1 ).xyz;
			float4 tex2DNode8 = tex2D( _MetalicMap,i.uv_MetalicMap);
			o.Metallic = ( tex2DNode8.r * _Metalic );
			o.Smoothness = ( tex2DNode8.g * _Smoothness );
			o.Occlusion = ( tex2DNode8.b * _AmbientOcclusion );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
627;29;969;916;813.3995;182.8;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;51;-2144.3,-281.4005;Float;1426.079;645.2802;Traffic Light Emission Setup;10;50;49;48;44;47;46;45;43;16;52
Node;AmplifyShaderEditor.CommentaryNode;52;-1232.3,-222.2006;Float;148.64;582.5618;Add Switches;0
Node;AmplifyShaderEditor.CommentaryNode;15;-637,343;Float;588;557;Metalic, Smoothness and AO Setutp;7;9;10;8;11;14;12;13
Node;AmplifyShaderEditor.CommentaryNode;7;-689,40;Float;566;271;Normal Settings;2;5;6
Node;AmplifyShaderEditor.CommentaryNode;4;-1380.8,-776.7995;Float;557;449;Albedo Settings;3;1;3;2
Node;AmplifyShaderEditor.ColorNode;2;-1242.8,-731.7995;Float;Constant;_Color0;Color 0;1;1,1,1,1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-979.8,-600.7999;Float;COLOR;0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;1;-1339.8,-544.8002;Float;Property;_AlbedoMap;Albedo Map;0;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;6;-666,182;Float;Property;_NormalScale;Normal Scale;2;1;0;0
Node;AmplifyShaderEditor.SamplerNode;5;-448,108;Float;Property;_NormalMap;Normal Map;1;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-209,680;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-211,567;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-205,781;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SamplerNode;8;-574,386;Float;Property;_MetalicMap;Metalic Map;3;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;9;-587,572;Float;Property;_Metalic;Metalic;4;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;10;-589,664;Float;Property;_Smoothness;Smoothness;5;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;11;-584,760;Float;Property;_AmbientOcclusion;Ambient Occlusion;6;1;0;1
Node;AmplifyShaderEditor.SamplerNode;16;-2096.899,-174.4001;Float;Property;_EmissionMask;Emission Mask;7;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1972.201,41.19991;Float;Property;_EmissiveStrength;Emissive Strength;8;2;0;0
Node;AmplifyShaderEditor.LerpOp;45;-1444.6,-163.4002;Float;FLOAT4;0.0,0,0,0;FLOAT4;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.LerpOp;46;-1449.8,-26.90027;Float;FLOAT4;0.0,0,0,0;FLOAT4;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.LerpOp;47;-1448.5,110.8998;Float;FLOAT4;0.0,0,0,0;FLOAT4;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1657.801,-56.00012;Float;FLOAT4;0.0,0,0,0;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;-1041.6,-206.7005;Float;OBJECT;0.0;OBJECT;0.0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-886.9998,-80.70045;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1414.2,241.1997;Float;Constant;_EmptyValue;Empty Value;9;0;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;2;Float;ASEMaterialInspector;Standard;PolyPixel/TrafficLights(TBC);False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;1;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;5;5;6;0
WireConnection;13;0;8;2
WireConnection;13;1;10;0
WireConnection;12;0;8;1
WireConnection;12;1;9;0
WireConnection;14;0;8;3
WireConnection;14;1;11;0
WireConnection;45;1;44;0
WireConnection;45;2;16;1
WireConnection;46;1;44;0
WireConnection;46;2;16;2
WireConnection;47;1;44;0
WireConnection;47;2;16;3
WireConnection;44;0;1;0
WireConnection;44;1;43;0
WireConnection;50;0;49;0
WireConnection;0;0;3;0
WireConnection;0;1;5;0
WireConnection;0;3;12;0
WireConnection;0;4;13;0
WireConnection;0;5;14;0
ASEEND*/
//CHKSM=5C9CA3C0D75A1F74C3081A115BA42380A8D056FB