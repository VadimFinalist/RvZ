// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/StandardSimpleTint"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_TintColor("Tint Color", Color) = (1,1,1,0)
		_AlbedoMap("Albedo Map", 2D) = "white" {}
		_EmissiveColor("Emissive Color", Color) = (1,1,1,0)
		_EmissiveStrenght("Emissive Strenght", Float) = 0
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_CompactMap("Compact Map", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Roughtness("Roughtness", Range( 0 , 1)) = 1
		_AmbientOcclusion("Ambient Occlusion", Range( 0 , 1)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+5" }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 5.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_NormalMap;
			float2 uv_AlbedoMap;
			float2 uv_CompactMap;
		};

		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform sampler2D _AlbedoMap;
		uniform float4 _TintColor;
		uniform float4 _EmissiveColor;
		uniform float _EmissiveStrenght;
		uniform sampler2D _CompactMap;
		uniform float _Metalic;
		uniform float _Roughtness;
		uniform float _AmbientOcclusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap,i.uv_NormalMap) ,_NormalScale );
			float4 tex2DNode2 = tex2D( _AlbedoMap,i.uv_AlbedoMap);
			o.Albedo = lerp( tex2DNode2 , _TintColor , tex2DNode2.a ).rgb;
			o.Emission = ( ( _EmissiveColor * _EmissiveStrenght ) * tex2DNode2 ).xyz;
			float4 tex2DNode10 = tex2D( _CompactMap,i.uv_CompactMap);
			o.Metallic = ( tex2DNode10.r * _Metalic );
			o.Smoothness = ( tex2DNode10.g * _Roughtness );
			o.Occlusion = ( tex2DNode10.b * _AmbientOcclusion );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
219;32;1158;915;1417.45;564.8491;1.030047;True;True
Node;AmplifyShaderEditor.CommentaryNode;28;-834.5,-1067.3;Float;713;467;Emissive Settings;4;22;23;27;24
Node;AmplifyShaderEditor.CommentaryNode;21;-844.5,204.7;Float;689;593;Metalic, Roughness and AO Setup;7;13;12;11;14;10;15;16
Node;AmplifyShaderEditor.CommentaryNode;20;-1002.5,-41.30005;Float;627;236;Normal Settings;2;7;5
Node;AmplifyShaderEditor.CommentaryNode;19;-827.6999,-556.5;Float;637;493;Albedo Tint Settings;3;2;17;18
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;7;Float;ASEMaterialInspector;Standard;PolyPixel/StandardSimpleTint;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Opaque;0.5;True;True;5;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-316,682;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-313,514;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-315,387;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;11;-741,507;Float;Property;_Metalic;Metalic;7;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;12;-741,594;Float;Property;_Roughtness;Roughtness;8;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;13;-744,694;Float;Property;_AmbientOcclusion;Ambient Occlusion;9;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;7;-984,101;Float;Property;_NormalScale;Normal Scale;5;1;0;0
Node;AmplifyShaderEditor.LerpOp;18;-357.9,-290.1;Float;FLOAT4;0.0,0,0,0;COLOR;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.SamplerNode;2;-803,-255;Float;Property;_AlbedoMap;Albedo Map;1;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.ColorNode;17;-714.9,-470.1;Float;Property;_TintColor;Tint Color;0;1,1,1,0
Node;AmplifyShaderEditor.SamplerNode;5;-753,11;Float;Property;_NormalMap;Normal Map;4;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-485.5,-861.3;Float;COLOR;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-275.5,-787.3;Float;COLOR;0.0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.ColorNode;22;-760.5,-990.3;Float;Property;_EmissiveColor;Emissive Color;2;1,1,1,0
Node;AmplifyShaderEditor.RangedFloatNode;23;-715.5,-762.3;Float;Property;_EmissiveStrenght;Emissive Strenght;3;0;0;0
Node;AmplifyShaderEditor.SamplerNode;10;-720,263;Float;Property;_CompactMap;Compact Map;6;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
WireConnection;0;0;18;0
WireConnection;0;1;5;0
WireConnection;0;2;27;0
WireConnection;0;3;14;0
WireConnection;0;4;15;0
WireConnection;0;5;16;0
WireConnection;16;0;10;3
WireConnection;16;1;13;0
WireConnection;15;0;10;2
WireConnection;15;1;12;0
WireConnection;14;0;10;1
WireConnection;14;1;11;0
WireConnection;18;0;2;0
WireConnection;18;1;17;0
WireConnection;18;2;2;4
WireConnection;5;5;7;0
WireConnection;24;0;22;0
WireConnection;24;1;23;0
WireConnection;27;0;24;0
WireConnection;27;1;2;0
ASEEND*/
//CHKSM=C6A52A120FDFD21B970A686FA089E4C819C9A5F7