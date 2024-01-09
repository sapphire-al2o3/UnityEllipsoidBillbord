using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BillboardEllipsoid : MonoBehaviour
{
    [SerializeField]
    Material _material;

    Mesh _mesh;

    void Start()
    {
        Vector3[] vertices = new Vector3[]
        {
            new Vector3(0, 0, 0),
            new Vector3(0, 0, 1),
            new Vector3(0, 0, 0),
            new Vector3(0, 0, 1)
        };

		Vector3[] normals = new Vector3[]
        {
            new Vector3(-0.5f, -0.5f, -1),
            new Vector3(-0.5f,  0.5f,  1),
            new Vector3( 0.5f, -0.5f, -1),
            new Vector3( 0.5f,  0.5f,  1)
        };

        Vector2[] uvs = new Vector2[]
        {
            new Vector2(0, 0),
            new Vector2(0, 1),
            new Vector2(1, 0),
            new Vector2(1, 1)
        };

		int[] indices = new int[]
        {
            0, 1, 2,
            2, 1, 3
        };

        _mesh = new Mesh();
        _mesh.SetVertices(vertices);
        _mesh.SetNormals(normals);
        _mesh.SetUVs(0, uvs);
        _mesh.SetIndices(indices, MeshTopology.Triangles, 0);

        _mesh.RecalculateBounds();
    }

    private void OnDestroy()
    {
        Destroy(_mesh);
    }

	void Update()
	{
		for (int i = 0; i < 1; i++)
		{
			for (int j = 0; j < 1; j++)
			{
				Quaternion rot = Quaternion.Euler(j * 36.0f, i * 36.0f, 0);
				rot = transform.rotation * rot;
				Graphics.DrawMesh(_mesh, transform.position, rot, _material, 0);
			}
		}
	}
}
