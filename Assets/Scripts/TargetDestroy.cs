using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TargetDestroy : MonoBehaviour
{
    public Transform explosion;//파괴 시 파티클


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void DestroySelf(Vector3 pos)
    {
        //Instantiate(explosion, pos, Quaternion.identity);
        //Destroy(gameObject);
        StartCoroutine(DestroyLazy());
    }
    IEnumerator DestroyLazy()
    {
        Material mat1 = GetComponent<Renderer>().material;
        Material mat2 = transform.Find("Base").GetComponent<Renderer>().material;
        Material mat3 = transform.Find("Turret/Barrel").GetComponent<Renderer>().material;
        Color color = mat1.color;

        for(float alpha = 1; alpha >= 0; alpha -= 0.02f)
        {
            color.a = alpha;
            mat1.color = color;
            mat2.color = color;
            mat3.color = color;

            yield return null;
        }
        Destroy(gameObject);
    }
    //164번 해오기
}
