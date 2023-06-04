// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "External_Flame"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_fire("fire", 2D) = "white" {}
		_Cloud_999("Cloud_999", 2D) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend One One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			half2 uv_texcoord;
			half2 uv2_texcoord2;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _fire;
		uniform half4 _fire_ST;
		uniform sampler2D _Cloud_999;
		uniform half4 _Cloud_999_ST;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_fire = i.uv_texcoord * _fire_ST.xy + _fire_ST.zw;
			half4 tex2DNode1 = tex2D( _fire, uv_fire );
			o.Emission = ( ( tex2DNode1 * i.uv2_texcoord2.y ) * i.vertexColor ).rgb;
			o.Alpha = ( tex2DNode1.r * i.vertexColor.a );
			float2 uv_Cloud_999 = i.uv_texcoord * _Cloud_999_ST.xy + _Cloud_999_ST.zw;
			half ifLocalVar9 = 0;
			if( tex2D( _Cloud_999, uv_Cloud_999 ).r >= i.uv2_texcoord2.x )
				ifLocalVar9 = 1.0;
			else
				ifLocalVar9 = 0.0;
			clip( ( i.vertexColor.a * ifLocalVar9 ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
7;7;1906;1004;3341.146;1131.464;2.549535;True;True
Node;AmplifyShaderEditor.RangedFloatNode;10;-1125,474.5;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-961,510.5;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1154,-305.5;Float;True;Property;_fire;fire;1;0;Create;True;0;0;False;0;82c8ffbbeebfd3846ba1408f9fce3b4b;82c8ffbbeebfd3846ba1408f9fce3b4b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;6;-1228,333.5;Float;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-1399,24.5;Float;True;Property;_Cloud_999;Cloud_999;2;0;Create;True;0;0;False;0;d340f51752ddd92448492c250d66a711;d340f51752ddd92448492c250d66a711;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;5;-1001,-74.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ConditionalIfNode;9;-817,197.5;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-764,-217.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-571,-46.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-490,124.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-552,-179.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-159,-102;Half;False;True;2;Half;ASEMaterialInspector;0;0;Unlit;External_Flame;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;14;1
WireConnection;9;1;6;1
WireConnection;9;2;10;0
WireConnection;9;3;10;0
WireConnection;9;4;11;0
WireConnection;3;0;1;0
WireConnection;3;1;6;2
WireConnection;8;0;1;1
WireConnection;8;1;5;4
WireConnection;12;0;5;4
WireConnection;12;1;9;0
WireConnection;13;0;3;0
WireConnection;13;1;5;0
WireConnection;0;2;13;0
WireConnection;0;9;8;0
WireConnection;0;10;12;0
ASEEND*/
//CHKSM=CF79496E68844C929F1A4D9007647FA561F8716F