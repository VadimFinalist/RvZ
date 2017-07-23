// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/StandardSimple"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_BaseColor("Base Color", Color) = (1,1,1,0)
		_AlbertoMap("Alberto Map", 2D) = "white" {}
		_EmissiveColor("Emissive Color", Color) = (1,1,1,0)
		_EmissivePower("Emissive Power", Float) = 0
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_CompactMap("Compact Map", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Roughtness("Roughtness", Range( 0 , 1)) = 1
		_AmbientOcclusion("Ambient Occlusion", Range( 0 , 1)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+3" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_NormalMap;
			float2 uv_AlbertoMap;
			float2 uv_CompactMap;
		};

		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform float4 _BaseColor;
		uniform sampler2D _AlbertoMap;
		uniform float4 _EmissiveColor;
		uniform float _EmissivePower;
		uniform sampler2D _CompactMap;
		uniform float _Metalic;
		uniform float _Roughtness;
		uniform float _AmbientOcclusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap,i.uv_NormalMap) ,_NormalScale );
			float4 tex2DNode2 = tex2D( _AlbertoMap,i.uv_AlbertoMap);
			o.Albedo = ( _BaseColor * tex2DNode2 ).xyz;
			o.Emission = ( ( _EmissiveColor * _EmissivePower ) * tex2DNode2 ).xyz;
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
219;32;1158;915;970;132.2001;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;41;-806.7007,-891.8999;Float;575;452;Emissive Settings;4;40;37;38;39
Node;AmplifyShaderEditor.CommentaryNode;36;-836.6006,291.4;Float;690.4803;540.44;Metalic, Smoothness and AO Setup;7;10;13;12;11;14;15;16
Node;AmplifyShaderEditor.CommentaryNode;35;-999.4,20.50006;Float;703.7902;258.5101;Normal Setup;2;7;5
Node;AmplifyShaderEditor.CommentaryNode;34;-808.0003,-415.3002;Float;574.3201;421.8598;Alberto Setup;3;32;33;2
Node;AmplifyShaderEditor.SamplerNode;2;-766,-177;Float;Property;_AlbertoMap;Alberto Map;1;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SamplerNode;5;-752,65.6;Float;Property;_NormalMap;Normal Map;4;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-316,706.6999;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-313,538.6999;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-315,411.7;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;11;-741,531.6999;Float;Property;_Metalic;Metalic;7;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;12;-741,618.6999;Float;Property;_Roughtness;Roughtness;8;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;13;-744,718.6999;Float;Property;_AmbientOcclusion;Ambient Occlusion;9;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;7;-987,177.6;Float;Property;_NormalScale;Normal Scale;5;1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-371.9,-236.1;Float;COLOR;0.0,0,0,0;FLOAT4;0,0,0,0
Node;AmplifyShaderEditor.ColorNode;32;-671.9,-358.1;Float;Property;_BaseColor;Base Color;0;1,1,1,0
Node;AmplifyShaderEditor.RangedFloatNode;38;-747.7007,-587.8999;Float;Property;_EmissivePower;Emissive Power;3;0;0;0
Node;AmplifyShaderEditor.ColorNode;37;-771.7007,-827.8999;Float;Property;_EmissiveColor;Emissive Color;2;1,1,1,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-525.7007,-745.8999;Float;COLOR;0.0,0,0,0;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-368.7007,-614.8999;Float;COLOR;0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;2;Float;ASEMaterialInspector;Standard;PolyPixel/StandardSimple;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;3;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.SamplerNode;10;-747.4999,330.5999;Float;Property;_CompactMap;Compact Map;6;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
WireConnection;5;5;7;0
WireConnection;16;0;10;3
WireConnection;16;1;13;0
WireConnection;15;0;10;2
WireConnection;15;1;12;0
WireConnection;14;0;10;1
WireConnection;14;1;11;0
WireConnection;33;0;32;0
WireConnection;33;1;2;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;40;0;39;0
WireConnection;40;1;2;0
WireConnection;0;0;33;0
WireConnection;0;1;5;0
WireConnection;0;2;40;0
WireConnection;0;3;14;0
WireConnection;0;4;15;0
WireConnection;0;5;16;0
ASEEND*/
//CHKSM=6D3D0666993B85FFE22769604633F3CF6B92EF07